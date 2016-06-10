From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 10 Jun 2016 08:58:41 +0000
Subject: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <Pine.LNX.4.44L0.1606081352250.2191-100000@iolanthe.rowland.org>
References: <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
 <Pine.LNX.4.44L0.1606081352250.2191-100000@iolanthe.rowland.org>
Message-ID: <B256D81BAE5131468A838E5D7A24364101650BA1DB@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan, 

> -----Original Message-----
> From: Alan Stern [mailto:stern at rowland.harvard.edu]
> Sent: 2016?6?9? 3:14
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Ferre, Nicolas
> <Nicolas.FERRE@atmel.com>; Rob Herring <robh+dt@kernel.org>; Pawel Moll
> <pawel.moll@arm.com>; Mark Brown <broonie@kernel.org>; Ian Campbell
> <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
> Alexandre Belloni <alexandre.belloni@free-electrons.com>; Kernel development
> list <linux-kernel@vger.kernel.org>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; USB list <linux-usb@vger.kernel.org>
> Subject: Re: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
> suspend
> 
> On Wed, 8 Jun 2016, Wenyou Yang wrote:
> 
> > In order to the save power consumption, as a workaround, suspend
> > forcibly the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI
> > Interrupt Configuration Register in the SFRs while OHCI USB suspend.
> >
> > This suspend operation must be done before the USB clock is disabled,
> > resume after the USB clock is enabled.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> 
> You never answered the questions I posted for the first version of this
> patch:
> 
> What does this mean?  What does suspending a port do?  Is it the same as a
> normal USB port suspend?
> 
> If it is the same, why doesn't the USB_PORT_FEAT_SUSPEND subcase of the
> SetPortFeature case in ohci_hub_control() already take care of this?

I remembered I answered your questions, http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/429245.html

Maybe not very clear.

> 
> Alan Stern


Best Regards,
Wenyou Yang
