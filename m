From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 12 Sep 2013 16:44:46 +0100
Subject: [linux-sunxi] Re: [PATCH 4/4] Add arch count timer node in dts
 for Allwinner A20(sunxi 7i).
In-Reply-To: <20130912145756.GD22013@e106331-lin.cambridge.arm.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-5-git-send-email-cinifr@gmail.com>
 <20130912145756.GD22013@e106331-lin.cambridge.arm.com>
Message-ID: <1379000686.10076.76.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 15:57 +0100, Mark Rutland wrote:

> > +			interrupts = <1 13 0x308>,
> > +				     <1 14 0x308>,
> > +				     <1 11 0x308>,
> > +				     <1 10 0x308>;
> > +			clock-frequency = <24000000>;
> 
> If at all possible, your bootloader should set CNTFREQ, and
> clock-frequency should only be used as a last resort when it's
> impossible to get it to set CNTFREQ. It's not possible to set CNTFREQ
> from the non-secure side, so guests (which might not be Linux, and might
> not handle DT in the same way) may see a completely wrong frequency
> value.

https://groups.google.com/forum/#!topic/linux-sunxi/56Wj1IT-pKU

Ian.
