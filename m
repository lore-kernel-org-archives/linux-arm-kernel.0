From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Mar 2013 20:49:48 -0500
Subject: omap cpufreq driver in multi-platform kernels
Message-ID: <5152503C.2050503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin, Tony, Paul,

The omap cpufreq driver causes problems in multi-platform kernels
because it unconditionally registers with the cpufreq core and does not
check sufficiently that it is running on an omap platform. So on a
kernel with highbank and omap drivers booted on highbank, the
cpufreq-cpu0 driver fails to init. Any suggestions for how to fix? For
DT this could just be several of_machine_is_compatible checks, but I'm
not really sure for non-DT. Converting the driver to a platform driver
would be another option.

This will also affect other cpufreq-cpu0 users like iMX. And I'd guess
there may be other ARM cpufreq drivers that will cause the same issue.

Rob
