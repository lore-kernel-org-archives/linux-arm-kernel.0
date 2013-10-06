From: marex@denx.de (Marek Vasut)
Date: Sun, 6 Oct 2013 15:54:50 +0200
Subject: [PATCH 2/3 V4] i2c: mxs: Rework the PIO mode operation
In-Reply-To: <20131006135135.GB4173@katana>
References: <20131004052052.GA3194@katana>
 <1381060933-11111-1-git-send-email-marex@denx.de>
 <20131006135135.GB4173@katana>
Message-ID: <201310061554.50583.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> On Sun, Oct 06, 2013 at 02:02:13PM +0200, Marek Vasut wrote:
> > Analyze and rework the PIO mode operation. The PIO mode operation
> > was unreliable on MX28, by analyzing the bus with LA, the checks
> > for when data were available or were to be sent were wrong.
> > 
> > The PIO WRITE has to be completely reworked as it multiple problems.
> > The MX23 datasheet helped here, see comments in the code for details.
> > The problems boil down to:
> > - RUN bit in CTRL0 must be set after DATA register was written
> > - The PIO transfer must be 4 bytes long tops, otherwise use
> > 
> >   clock stretching.
> > 
> > Both of these fixes are implemented.
> > 
> > The PIO READ operation can only be done for up to four bytes as
> > we are unable to read out the data from the DATA register fast
> > enough.
> > 
> > This patch also tries to document the investigation within the
> > code.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Applied the series to for-next, thanks!
> 
> >     (and fixed my local pre-commit hook)
> 
> Yay :)

Thanks! It was quite a lengthy gig here ;-)

Best regards,
Marek Vasut
