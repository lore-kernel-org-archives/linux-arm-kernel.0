From: bryan.wu@canonical.com (Bryan Wu)
Date: Tue, 28 Jun 2011 17:02:40 +0800
Subject: [PATCH 0/3] Add generic idle notifiers
In-Reply-To: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
Message-ID: <BANLkTi=1ZfWfDpUkSV0f1KoWmkJbxHg=_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 10:46 AM, Todd Poynor <toddpoynor@google.com> wrote:
> Add notifiers for idle entry and exit, called with IDLE_START when a
> CPU goes idle and IDLE_END when it goes out of idle, based on the
> existing idle notifiers for the x86_64 arch.
>
> Convert x86_64 to use these notifiers, and call the notifiers on ARM.
>
> Convert the ARM LEDs events for idle start/end to these notifiers.
>

LinusW and I is working on consolidation LED events interface in ARM.
Please take a look at https://patchwork.kernel.org/patch/918792/

I do like to add notifiers into ledtrig-cpu driver, which can be also
shared by x86

Thanks,
-Bryan

> ?arch/arm/kernel/leds.c ? ? ? | ? 27 ++++++++++++++++++++++++++-
> ?arch/arm/kernel/process.c ? ?| ? ?5 ++---
> ?arch/x86/include/asm/idle.h ?| ? ?7 -------
> ?arch/x86/kernel/process_64.c | ? 18 ++----------------
> ?include/linux/cpu.h ? ? ? ? ?| ? ?7 +++++++
> ?kernel/cpu.c ? ? ? ? ? ? ? ? | ? 20 ++++++++++++++++++++
> ?6 files changed, 57 insertions(+), 27 deletions(-)
>
> --
> 1.7.3.1
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
