From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Oct 2013 10:52:56 +0530
Subject: [PATCH 038/228] cpufreq: sa11x0: Expose frequency table
In-Reply-To: <CAOesGMjE9s4KqHaAbkejZ-2GG4zv4Y1AxpgWzcMKovuMJFZ_-w@mail.gmail.com>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <e689bd437918e56ae50541a90a4b9c606bfb8bf4.1379063063.git.viresh.kumar@linaro.org>
 <CAOesGMjE9s4KqHaAbkejZ-2GG4zv4Y1AxpgWzcMKovuMJFZ_-w@mail.gmail.com>
Message-ID: <CAKohpokDf40BQwEypsBowyBJbDdvj-0CWypUw6sj9=vwc-FaRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 October 2013 08:23, Olof Johansson <olof@lixom.net> wrote:
> This causes breakage in linux-next for any SA1100 target:
>
> In file included from ../../arch/arm/mach-sa1100/irq.c:24:0:
> ../../arch/arm/mach-sa1100/generic.h:24:39: error: array type has
> incomplete element type
>  extern struct cpufreq_frequency_table sa11x0_freq_table[];

Ahh... sorry!! Below diff fixes it..

@Rafael: Please merge the attached fixup patch with $SUBJECT patch.

------x--------------x-----------

commit d2e1eb969ebdb66e3cc199fbbbe2e2a1a8e2960b
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri Oct 4 10:48:16 2013 +0530

    fixup! cpufreq: sa11x0: Expose frequency table
---
 arch/arm/mach-sa1100/generic.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index f5214ce..2d9bee0 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -3,6 +3,7 @@
  *
  * Author: Nicolas Pitre
  */
+#include <linux/cpufreq.h>
 #include <linux/reboot.h>

 extern void sa1100_timer_init(void);
@@ -19,8 +20,6 @@ extern void sa11x0_init_late(void);
 extern void sa1110_mb_enable(void);
 extern void sa1110_mb_disable(void);

-struct cpufreq_policy;
-
 extern struct cpufreq_frequency_table sa11x0_freq_table[];
 extern unsigned int sa11x0_freq_to_ppcr(unsigned int khz);
 extern int sa11x0_verify_speed(struct cpufreq_policy *policy);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fixup-cpufreq-sa11x0-Expose-frequency-table.patch
Type: application/octet-stream
Size: 1101 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131004/42425995/attachment.obj>
