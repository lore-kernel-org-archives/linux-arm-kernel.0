From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Dec 2015 09:42:15 +0000
Subject: [PICKME 0/2] cpufreq: New ST driver
Message-ID: <1449740537-12619-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Would you be kind enough to pick these 2 patches up please.
The have the required Acks.

Kind regards,
Lee

This is a re-write of the original submission, hence why the
change-log is omitted.  Basically almost everything has changed.
We are now using the new OPP framework and generic bindings
written by Viresh.
  
There are 'ARM' patches in the set which are not necessarily
related to CPUFreq, but are required to get it to work. Anyone
who is not interested in general STi DT changes can safely
ignore these.
  
v5 => v6:
 - Converted Kconfig and header comment to describe new driver
 - Complete re-write, using new Generic OPP framework
 - Supply description for "suitable for ALL versions" DEFINE
 - Pedantically re-ordered the #include files
 - Removed platform device registration in arch/arm/mach-sti

v4 => v5:
 - Converted driver away from being a platform device
  
v1 => v2 => v3 => v4:
 - Moot

Lee Jones (2):
  cpufreq: st: Provide runtime initialised driver for ST's platforms
  dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation

 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |  91 +++++++
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/sti-cpufreq.c                      | 294 +++++++++++++++++++++
 4 files changed, 396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
 create mode 100644 drivers/cpufreq/sti-cpufreq.c

-- 
1.9.1
