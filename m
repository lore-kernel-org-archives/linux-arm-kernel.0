From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Apr 2015 08:58:24 +0100
Subject: [PATCH RFC 09/11] sound/core: add IEC958 channel status helper
In-Reply-To: <551B5213.8070902@rock-chips.com>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
 <551A5B2F.50203@rock-chips.com>
 <20150331091329.GP24899@n2100.arm.linux.org.uk>
 <551B5213.8070902@rock-chips.com>
Message-ID: <20150401075824.GX24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 10:04:03AM +0800, Yakir wrote:
> Hi Russell,
> 
> ? 2015/3/31 17:13, Russell King - ARM Linux ??:
> >As for the channel number, this is intentionally left to the driver -
> >most cases I've found either the driver isn't interested, or where
> >they are interested (the only case I know of is my dw_hdmi ahb audio
> >driver), it's more appropriate to generate a baseline channel status,
> >and let the driver iterate over the channels adding the appropriate
> >channel number in.
> Okay, agree with you to keep baseline channel status, but seems dw_hdmi
> i2s audio are interested in channle number (to fill in schnl resigeters).

Correct - but it's pointless having it in this helper as I explained.
Please read my dw_hdmi-ahb-audio code to see why.

It would be wasteful to memset the structure back to zero, only to
re-fill it with exactly the same data except for the channel number.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
