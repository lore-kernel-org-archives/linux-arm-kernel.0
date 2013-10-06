From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 6 Oct 2013 15:51:35 +0200
Subject: [PATCH 2/3 V4] i2c: mxs: Rework the PIO mode operation
In-Reply-To: <1381060933-11111-1-git-send-email-marex@denx.de>
References: <20131004052052.GA3194@katana>
 <1381060933-11111-1-git-send-email-marex@denx.de>
Message-ID: <20131006135135.GB4173@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 06, 2013 at 02:02:13PM +0200, Marek Vasut wrote:
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

Applied the series to for-next, thanks!

>     (and fixed my local pre-commit hook)

Yay :)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131006/524b93c1/attachment.sig>
