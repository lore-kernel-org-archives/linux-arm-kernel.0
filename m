From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 20 Jan 2015 19:35:09 +0100 (CET)
Subject: [PATCH V2] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <201412281930.17676.marex@denx.de>
References: <1419762402-4548-1-git-send-email-stefan.wahren@i2se.com>
 <201412281930.17676.marex@denx.de>
Message-ID: <1913991589.463352.1421778909585.JavaMail.open-xchange@oxbaltgw06.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Marek Vasut <marex@denx.de> hat am 28. Dezember 2014 um 19:30 geschrieben:
>
>
> On Sunday, December 28, 2014 at 11:26:42 AM, Stefan Wahren wrote:
> > According to i.MX23 and i.MX28 reference manual the fractional
> > clock control registers must be addressed by byte instructions.
> >
> > This patch fixes the erroneous 32-bit access to these registers
> > and extends the comment in the init functions.
> >
> > Btw the imx23 init now uses a R-M-W sequence just like imx28 init
> > to avoid any clock glitches.
> >
> > The changes has been tested only with a i.MX28 board, because i don't
> > have access to an i.MX23 board.

since i've also a i.MX23 board, i tested this patch successful.

Any conserns about it?

> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> I don't see a problem,
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>
> Best regards,
> Marek Vasut
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
