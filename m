From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 15:40:04 +0000
Subject: [PATCH 2/2] ARM: dts: hummingboard: Setup pwm lines
In-Reply-To: <1425379336.3146.38.camel@pengutronix.de>
References: <E1YSWZL-0002Aw-B5@rmk-PC.arm.linux.org.uk>
 <1425379336.3146.38.camel@pengutronix.de>
Message-ID: <20150309154004.GR8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 11:42:16AM +0100, Philipp Zabel wrote:
> I wanted to point out these two are superfluous since pwm3/4 are
> disabled in the dtsi by default, but I just learned they aren't.
> 
> Should we add status = "disabled" to unusable (because not externally
> connected) PWMs, and if so, shouldn't that be done in the dtsi already?

I guess it should, but we'd first need to ensure that none of the
existing platforms would break through changing that (eg, through
a missing status = "okay" entry).

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
