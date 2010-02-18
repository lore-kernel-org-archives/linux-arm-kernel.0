From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 17 Feb 2010 18:02:25 -0600
Subject: [PATCH 2/7] OMAP3: cpuidle: configure latencies/thresholds from board
	file
In-Reply-To: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
References: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1266451350-4480-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPUidle C state latencies and thresholds are dependent on various
board specific details.  This patch makes it possible to configure
these values from the respective board files.

omap3_pm_init_cpuidle() can now be optionally called from board files
to pass board specific cpuidle parameters.  If the board files do not
use this function to pass the params default values are used which
might cause higher consumption dur to wrong state selection by the
governor.

This patch only updates the 3430sdp board files to use
omap3_pm_init_cpuidle().
