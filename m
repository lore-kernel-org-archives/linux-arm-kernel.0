From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 30 Sep 2013 13:22:01 +0200
Subject: [PATCH 2/3 V3] i2c: mxs: Rework the PIO mode operation
In-Reply-To: <1380497035-7457-2-git-send-email-marex@denx.de>
References: <1380497035-7457-1-git-send-email-marex@denx.de>
 <1380497035-7457-2-git-send-email-marex@denx.de>
Message-ID: <20130930112201.GE3222@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 01:23:54AM +0200, Marek Vasut wrote:
> Analyze and rework the PIO mode operation. The PIO mode operation
> was unreliable on MX28, by analyzing the bus with LA, the checks
> for when data were available or were to be sent were wrong.
> 
> The PIO WRITE has to be completely reworked as it multiple problems.
> The MX23 datasheet helped here, see comments in the code for details.
> The problems boil down to:
> - RUN bit in CTRL0 must be set after DATA register was written
> - The PIO transfer must be 4 bytes long tops, otherwise use
>   clock stretching.
> Both of these fixes are implemented.
> 
> The PIO READ operation can only be done for up to four bytes as
> we are unable to read out the data from the DATA register fast
> enough.
> 
> This patch also tries to document the investigation within the
> code.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Yay, there it is. Thanks, looks good to me. Will wait a few days so
people can donate Tested-by tags.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/e3383226/attachment.sig>
