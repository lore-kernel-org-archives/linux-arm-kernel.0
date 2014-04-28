From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Apr 2014 10:31:44 +0200
Subject: [PATCH RFC 0/5] Dove PMU support
In-Reply-To: <535E079B.6010701@gmail.com>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <535E079B.6010701@gmail.com>
Message-ID: <20140428083144.GB6650@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Russell,
> 
> thanks for dropping those patches. I know you are packed with a bunch
> of other patch sets, so if you agree, I can pick up your Dove related
> patches and finish them.
> 
> One thing that comes into my mind is, that we moved Dove DT to
> mach-mvebu starting with v3.15-rc1 so we need to find a better place
> for the driver than mach-dove.

Create drivers/pmu ?

The cpufreq driver also needs access to registers within the pmu
range. Should it be part of pmu.c, or should we export a regmap which
cpufreq can use?

	Andrew
