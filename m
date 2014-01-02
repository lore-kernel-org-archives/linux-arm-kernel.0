From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jan 2014 17:21:02 +0000
Subject: [BUG] cpufreq: bL_switcher can fail to build
Message-ID: <20140102172102.GA7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The randconfig results from the autobuilder produced this error for
the big.LITTLE cpufreq code for the omap4430-sdp randconfig build on
New Years day.

drivers/built-in.o: In function `bL_cpufreq_set_rate':
powercap_sys.c:(.text+0x5ed9a0): undefined reference to `bL_switch_request_cb'

Maybe CONFIG_ARM_BIG_LITTLE_CPUFREQ needs to depend on CONFIG_BIG_LITTLE ?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
