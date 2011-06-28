From: toddpoynor@google.com (Todd Poynor)
Date: Mon, 27 Jun 2011 19:46:27 -0700
Subject: [PATCH 0/3] Add generic idle notifiers
Message-ID: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add notifiers for idle entry and exit, called with IDLE_START when a
CPU goes idle and IDLE_END when it goes out of idle, based on the
existing idle notifiers for the x86_64 arch.

Convert x86_64 to use these notifiers, and call the notifiers on ARM.

Convert the ARM LEDs events for idle start/end to these notifiers.

 arch/arm/kernel/leds.c       |   27 ++++++++++++++++++++++++++-
 arch/arm/kernel/process.c    |    5 ++---
 arch/x86/include/asm/idle.h  |    7 -------
 arch/x86/kernel/process_64.c |   18 ++----------------
 include/linux/cpu.h          |    7 +++++++
 kernel/cpu.c                 |   20 ++++++++++++++++++++
 6 files changed, 57 insertions(+), 27 deletions(-)

-- 
1.7.3.1
