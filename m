From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 9 Dec 2011 16:14:14 -0800
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <20111209175327.GQ31337@atomide.com>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
 <20111209010147.GH7913@S2100-06.ap.freescale.net>
 <4EE18403.30604@nvidia.com>
 <20111209043220.GJ7913@S2100-06.ap.freescale.net>
 <4EE192DC.3080209@nvidia.com>
 <CAA+hA=Sx=tmnjsY_7EF8NciZO4PvgYOCgRNK9WsGpKmJ8X-r3g@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17518604C3@HQMAIL01.nvidia.com>
 <20111209172407.GP31337@atomide.com> <20111209175327.GQ31337@atomide.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF175186060C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote at Friday, December 09, 2011 10:53 AM:
> * Tony Lindgren <tony@atomide.com> [111209 08:53]:
...
> > For letting a device do it's pingroup in DT, I've played with the
> > following:
> >
> > 	/*      mux func phandle mux func name    hw initial flags */
> > 	pins = <&uart3_rx_irrx>, "uart3_rx_irrx", <0xdeadbeef>,
> > 		<&uart3_tx_irtx>, "uart3_tx_irtx", <0xdeadbeef>;
> >
> > But it seems that doing mixed-property arrays gets nasty as any
...
> > So I've pretty much come to the conclusion that we would have to
> > use something like this instead:
> >
> > 	/*      phandle        f hw specific initial flags */
> > 	pins = <&uart3_rx_irrx 0 0xdeadbeef
> > 		&uart3_tx_irtx 0 0xdeadbeef>;
> >
> > This however has a problem for cases where we may not have a phandle
> > in DT for the mux function. For example, let's assume that we'll have
> > tens of thousands of lines of mux data for omaps (we already have
> > over 6k LOC) and just want to load that from /lib/firmware to avoid
> > bloating the kernel. In that case we won't have the phandle for the
> > mux function in DT.
...
> Oh forgot to mention of course what Benoit came up which is reg-names.
> That of course is doable with both phandles and pin names:
> 
> So optionally either
> 
> 	pins = <&uart3_rx_irrx &uart3_tx_irtx>;
> or
> 
> 	pin-names = "uart3_rx_irrx",  "uart3_tx_irtx";

Tony,

It sounds like you've already started working on some DT bindings for
pin muxing. Are you just at the thinking stage as above, or do you have
any concrete code? I'd obviously be interested in looking at any early
bindings to see if I can port the Tegra pinctrl driver to use them.

Thanks.

-- 
nvpublic
