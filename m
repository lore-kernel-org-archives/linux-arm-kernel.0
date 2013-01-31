From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 31 Jan 2013 05:27:26 +0000
Subject: [PATCH 1/2] ASoC: tlv320aic3x: Convert mic bias to a supply widget
In-Reply-To: <20130131023221.GA6027@opensource.wolfsonmicro.com>
References: <1359552155-17426-1-git-send-email-gururaja.hebbar@ti.com>
 <20130131023221.GA6027@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB59A8C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 08:02:25, Mark Brown wrote:
> On Wed, Jan 30, 2013 at 06:52:35PM +0530, Hebbar Gururaja wrote:
> 
> > Convert MicBias widgets to supply widget.
> 
> > On tlv320aic3x, Mic bias power on/off shares the same register bits
> > with output mic bias voltage.  So, when power on mic bias, we need
> > reclaim it to voltage value.
> 
> This should update machine drivers that use the CODEC too.

Yes. I have that patch ready. Once this is accepted, I will send all 
the patch as a series

> 
> > +- ai3x-micbias-vg - MicBias Voltage required.
> > +	1 - MICBIAS output is powered to 2.0V,
> > +	2 - MICBIAS output is powered to 2.5V,
> > +	3 - MICBIAS output is connected to AVDD,
> > +	If this node is not mentioned or if the value is incorrect, then MicBias
> > +	is powered down.
> 
> Would 2.0V not be a more sensible default (it is the lowest voltage so
> is unlikely to cause hardware damage if it's wrong)?

The only reason I made this choice was because none of the existing platforms
using this codec are setting the MicBias.

> 
> Otherwise this looks good.

Ok. I will send all the patch as a series now.

> 


Regards, 
Gururaja
