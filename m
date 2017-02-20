From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 20 Feb 2017 19:17:12 +0100
Subject: [PATCH v2 0/3] Extend rtc-armada38x support for Armada 7K/8K
In-Reply-To: <20170220175054.GP21222@n2100.armlinux.org.uk>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
 <20170220173633.d4ke4eohaacgsw3h@piout.net>
 <20170220175054.GP21222@n2100.armlinux.org.uk>
Message-ID: <20170220181712.yejnobmj3dhm5ev6@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/2017 at 17:50:54 +0000, Russell King - ARM Linux wrote:
> > The question being what does that do and whether it could be done in the
> > driver instead.
> 
> It's not specific to the Armada 8040, the same problem exists with
> Armada 38x, so holding this up for that reason does not make sense.
> 

I agree, I will not delay the patch for that.

> I suspect that the errata is "RTC is not reset at power up" for the RTC
> power domain.
> 
> I don't know where the value of 0x2000 comes from for the correction
> value, all I know is that's the value uboot uses with "date reset".
> We probably do _not_ want the driver writing that each time the
> kernel boots, since that's a tuning parameter.
> 

It is probably a calibration offset. It may be worth exposing to
userspace but without more information, I doubt we can make something
useful out of it.



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
