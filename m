From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Mar 2014 23:46:02 +0100
Subject: [PATCH v5 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1394762863-12154-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140328224602.GB29200@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 07:07:43PM -0700, Bjorn Andersson wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> generated for each block-size data transfer).
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

spatch told me...

drivers/i2c/busses/i2c-qup.c:481:7-26: pm_runtime_get_sync returns < 0 as error. Unecessary IS_ERR_VALUE@line 482

Fixed that and Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/18f44f2b/attachment.sig>
