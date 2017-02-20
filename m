From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 20 Feb 2017 18:36:33 +0100
Subject: [PATCH v2 0/3] Extend rtc-armada38x support for Armada 7K/8K
In-Reply-To: <87tw7oaj24.fsf@free-electrons.com>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
Message-ID: <20170220173633.d4ke4eohaacgsw3h@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/2017 at 18:06:11 +0100, Gregory CLEMENT wrote:
>  On ven., f?vr. 17 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> 
> > The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
> > the SOC integration differs in 2 points:
> >      - MBUS bridge timing initialization
> >      - IRQ configuration at SoC level
> >
> > This patch set extends the driver support to these SoCs family.
> >
> > In this second version the device tree was updated allowing to use the
> > RTC on Armada 80x0 SoCs. Indeed on the Armada 80x0, the RTC clock in
> > CP master is not connected (by package) to the oscillator. So this one
> > is disabled for the Armada 8020 and the Armada 8040. On these SoCs it
> > will be the RTC clock in CP slave connected to the oscillator which
> > will be used.
> 
> I saw on IRC than Russell managed to have a more coherent date with this
> series on his 8040 based board. For the record, as the U-Boot on this
> board didn't provide a "date reset" command for the RTC located on CP
> slave, then Russell needed to do the following:
> 
> devmem2 0xf428401c w 0
> devmem2 0xf4284018 w 0x2000

The question being what does that do and whether it could be done in the
driver instead.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
