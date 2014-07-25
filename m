From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 25 Jul 2014 16:05:28 -0400
Subject: [PATCH v2 0/5] generic IPI tracing
Message-ID: <1406318733-26754-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of the series initially posted here:

http://news.gmane.org/group/gmane.linux.kernel/thread=1750391

Steven / Ingo: Would you please merge those patches in your tree for some 
linux-next exposure and mainline inclusion? Patches 1 to 4 may go in now. 
I'm unsure about patch 5 so I'll leave it to your appreciation.

Changes since v1:

- added empty tracepoint_string when !CONFIG_TRACING, from Steven
- ipi_types[] is unconditionally marked with __tracepoint_string now
- added comment to arch/x86/kernel/smp.c justifying the #undef's
- collected ACKs, refined commit logs

diffstat:

 arch/arm/kernel/smp.c        | 70 ++++++++++++++++++------------
 arch/arm64/kernel/smp.c      | 65 +++++++++++++++++-----------
 arch/x86/kernel/smp.c        | 20 +++++++++
 include/linux/ftrace_event.h | 10 +++++
 include/trace/events/ipi.h   | 89 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 200 insertions(+), 54 deletions(-)


Nicolas
