From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 1 Jul 2013 07:50:51 +0200
Subject: [PATCH] i2c: iop3xxx: fix build failure after waitqueue changes
In-Reply-To: <1372455352-26260-1-git-send-email-khilman@linaro.org>
References: <1372455352-26260-1-git-send-email-khilman@linaro.org>
Message-ID: <20130701055051.GA2976@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 02:35:52PM -0700, Kevin Hilman wrote:
> There has long been a syntax problem in iop3xx_i2c_wait_event() which
> has been somehow hidden by the macros in <linux/wait.h>.  After some
> recent cleanup/rework of the wait_event_* helpers, the bug has come
> out from hiding and now results in build failure:
> 
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c: In function 'iop3xx_i2c_wait_event':
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:143: error: expected ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:157: error: expected ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:213: error: expected ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:291: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:551: error: expected ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:565: error: expected ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:764: error: expected ')' before ';' token
> /work/kernel/next/drivers/i2c/busses/i2c-iop3xx.c:176:778: error: expected ')' b
> 
> Fix by removing stray ';'
> 
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Applied to for-next, thanks! (Geez, that original code looks ugly...)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/27ff2488/attachment.sig>
