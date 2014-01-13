From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jan 2014 18:43:24 +0000
Subject: [BUILD BUG] msm: mdp4_drv_encoder.c
Message-ID: <20140113184324.GE15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Referencing mach/*.h from drivers does not work in multi-platform
kernels, and leads to errors such as this:

drivers/gpu/drm/msm/mdp4/mdp4_dtv_encoder.c:18:22: fatal error: mach/clk.h: No such file or directory

which were found via my allmodconfig build.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
