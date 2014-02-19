From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 19 Feb 2014 12:35:50 +0100
Subject: [PATCH V3 16/17] i2c: nomadik: Remove busy check for transfers
 at suspend late
In-Reply-To: <1392650462-14960-1-git-send-email-ulf.hansson@linaro.org>
References: <1392650462-14960-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140219113549.GB4345@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 04:21:02PM +0100, Ulf Hansson wrote:
> We should never be busy performing transfers at suspend late, thus
> there are no reason to check for it.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Adds a warning here:

  CC      drivers/i2c/busses/i2c-nomadik.o
drivers/i2c/busses/i2c-nomadik.c: In function 'nmk_i2c_suspend_late':
drivers/i2c/busses/i2c-nomadik.c:883:22: warning: unused variable 'nmk_i2c' [-Wunused-variable]


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/32b0cac8/attachment.sig>
