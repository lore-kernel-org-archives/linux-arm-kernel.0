From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Sun, 29 Apr 2012 19:32:24 +0200
Subject: [PATCH 1/3] pwm-core: fix compilation when OF is not selected
In-Reply-To: <20120429170431.GA29827@avionic-0098.adnet.avionic-design.de>
References: <1335713330-6488-1-git-send-email-eric@eukrea.com>
 <20120429170431.GA29827@avionic-0098.adnet.avionic-design.de>
Message-ID: <20120429193224.2cdc75e7@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Sun, 29 Apr 2012 19:04:31 +0200,
Thierry Reding <thierry.reding@avionic-design.de> a ?crit :

> * Eric B?nard wrote:
> > else we get the following error :
> > drivers/pwm/core.c: In function 'pwm_get':
> > drivers/pwm/core.c:538:3: error: implicit declaration of function 'of_pwm_request' [-Werror=implicit-function-declaration]
> > 
> > Signed-off-by: Eric B?nard <eric@eukrea.com>
> 
> This is solved a little differently in the latest patches. That no longer has
> the of_pwm_request() function protected by #ifdef CONFIG_OF, but rather calls
> it in a IS_ENABLED(CONFIG_OF)-protected block so that it will still receive
> compile coverage in !OF configurations but at the same time will be removed
> by the compiler's dead code elimination. 
> 
OK, this was based on de8eba0b1e53ee0d2e3270c12d6482971e2beb4b in your
tree dated the 27th march. I now see you updated it on friday.

Eric 
