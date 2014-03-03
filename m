From: joshc@codeaurora.org (Josh Cartwright)
Date: Mon, 3 Mar 2014 12:08:09 -0600
Subject: spear-cpufreq + multiplatform?
Message-ID: <20140303180809.GA28282@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey folks-

I noticed booting today's next on a non-spear platform, that I'm seeing
the following in my logs:

	[    2.126494] spear_cpufreq: Invalid cpufreq_tbl

Looking closer, it looks like the spear-cpufreq driver has a
late_initcall() that's not too multiplatform friendly.  Perhaps the
spear cpufreq initialization routine should be called explicitly from
some platform-specific code, or explicitly check to ensure it's running
on SPEAr?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
