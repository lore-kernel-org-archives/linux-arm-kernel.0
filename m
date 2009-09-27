From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 27 Sep 2009 10:01:08 +0300
Subject: [PATCH v2 4/5] Add suspend/resume support for rx1950
In-Reply-To: <20090927061951.GM31920@trinity.fluff.org>
References: <4abe82e7.0405560a.5ebe.4296@mx.google.com>
	<20090927061951.GM31920@trinity.fluff.org>
Message-ID: <200909271001.20642.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 27 ???????? 2009 09:19:51 ????? Ben Dooks ???????:
> >  		__raw_writel(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
> > +		if (machine_is_rx1950()) {
> > +			/* According to S3C2442 user's manual, page 7-17,
> > +			 * when the system is operating in NAND boot mode,
> > +			 * the hardware pin configuration - EINT[23:21] ???
> > +			 * must be set as input for starting up after
> > +			 * wakeup from sleep mode */
> 
> given this is generic to the s3c2442, why put this here? it also holds
> for the s3c2440 too... think about an implementation for the cpu's
> sysdev for all nand-booting systems.

Well, actually I thought that suspend for h1940 and rx3000 works without these 
tricks... Ok, I'll make it generic for s3c2442 CPU.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090927/1a0fe903/attachment.sig>
