From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 29 Apr 2012 19:04:31 +0200
Subject: [PATCH 1/3] pwm-core: fix compilation when OF is not selected
In-Reply-To: <1335713330-6488-1-git-send-email-eric@eukrea.com>
References: <1335713330-6488-1-git-send-email-eric@eukrea.com>
Message-ID: <20120429170431.GA29827@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eric B?nard wrote:
> else we get the following error :
> drivers/pwm/core.c: In function 'pwm_get':
> drivers/pwm/core.c:538:3: error: implicit declaration of function 'of_pwm_request' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>

This is solved a little differently in the latest patches. That no longer has
the of_pwm_request() function protected by #ifdef CONFIG_OF, but rather calls
it in a IS_ENABLED(CONFIG_OF)-protected block so that it will still receive
compile coverage in !OF configurations but at the same time will be removed
by the compiler's dead code elimination.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120429/60616669/attachment.sig>
