From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jan 2014 14:34:41 +0000
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <20140116140858.GD27282@piout.net>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <20140116140858.GD27282@piout.net>
Message-ID: <20140116143441.GW15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 03:08:58PM +0100, Alexandre Belloni wrote:
> I hit exactly the same issue trying to support a TiWi chip on SDIO. On
> my side, I used vmmc-supply to drive the reset GPIO with a fixed
> regulator. The other thing needed was the clock. That one, I put it in
> the board file. I guess we need a way to describe children of the SDIO
> host and the host driver would be responsible to manage power supplies,
> resets and clocks...

I thought about doing that, but the issue I run into is that I need
four regulators in total, and some way to combine them so that I get
the right sequence.

The sequence currently being done in the board in the FSL v3.0.35
kernel is:

- drive both reset gpio low
- power up wifi/bt via gpio
- power up oscillator via gpio
- wait 2ms
- drive both reset gpios high
- wait 2ms
- detect sdio device

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
