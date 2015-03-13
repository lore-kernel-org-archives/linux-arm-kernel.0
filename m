From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 12:33:24 +0000
Subject: [PATCH 6/9] ARM: dt: dove: add Dove PMU DT entry to dove.dtsi
In-Reply-To: <20150313133038.0a3ae8d1@free-electrons.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
 <20150313133038.0a3ae8d1@free-electrons.com>
Message-ID: <20150313123324.GH8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 01:30:38PM +0100, Thomas Petazzoni wrote:
> Dear Russell King,
> 
> On Thu, 12 Mar 2015 18:31:21 +0000, Russell King wrote:
> 
> > +			pmu: power-management at d0000 {
> > +				compatible = "marvell,dove-pmu";
> > +				reg = <0xd0000 0x8000>, <0xd8000 0x8000>;
> 
> If I'm not wrong, the registers of the RTC are at 0xd8500, which is
> also covered by this new pmu node. It does work because you're using
> of_iomap(), but it isn't really ideal.
> 
> Maybe some sort of syscon/regmap thing should be used?

Please look at the locking that would require and the locking required
for PM domains (and as I've previously explained, apparently the hardware
requires a specific sequence of writes.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
