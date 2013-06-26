From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 26 Jun 2013 17:19:20 +0000 (UTC)
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <51C9F0A8.1050607@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com>
Message-ID: <alpine.DEB.2.02.1306261713260.6135@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun 2013, Tom Rini wrote:

> On 06/25/2013 02:20 PM, Paul Walmsley wrote:
> 
> > BeagleBone-white has the additional complication that it is not easy 
> > to automate, due to the way that power is delivered to the board, so 
> > there is an extra dimension of difficulty there.
> 
> Ah-ha, I reproduced your failure.  If I make up a concat uImage + DTB,
> rather than pass them separately, it fails to boot.  If you switch to
> mainline U-Boot (v2012.10 or later) you get support for separate image +
> dtb (v2013.04 gives you bootz and zImage support).

Yeah, I've tried to keep the original bootloader that came on the first SD 
card image that was used on that device.  But am starting to think that 
it's time to stop my bootloader independence jihad, since appended DTB 
booting is so broken - have seen similar problems on SoCs from other 
vendors as well :-(

> And yeah, I feel your pain about power cycling BeagleBone-White.  The QA
> folks here sent me one of the relay controllers they use, and I think
> Felipe is partial to one from phidgets.

Thanks yeah, I should have been more specific in my whining.  Here I use a 
USB cable with VBUS sliced and then connected to an Ethernet-controlled DC 
relay.  But there's a power delivery issue where, under some conditions, 
supplemental power has to be supplied through the DC jack also, requiring 
two separate contacts to be switched :-(


- Paul
