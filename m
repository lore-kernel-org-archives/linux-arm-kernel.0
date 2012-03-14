From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 14 Mar 2012 19:38:38 +0200
Subject: [GIT PULL] cpufreq: OMAP updates for v3.4
In-Reply-To: <87wr6ngkrl.fsf@ti.com>
References: <87y5rci2na.fsf@ti.com>
 <CANOLnON91vXWb2L-FXjz3sqq-9j5SaEodtpt_yvFiN33D4Q3Ow@mail.gmail.com>
 <87wr6ngkrl.fsf@ti.com>
Message-ID: <CANOLnON+hHtnjo9samAqvXp_nVJMjQ7CnxMCe7ggO4UwYaz4rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 7:22 PM, Kevin Hilman <khilman@ti.com> wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>
> [...]
>
>>> Russell King (1):
>>> ? ? ?cpufreq: OMAP driver depends CPUfreq tables
>>
>> It seems this one got messed up, it says "default ARCH_OMAP2PLUS"
>> instead of depends.
>
> That was intentional. ?What do you think is messed up about it?
>
> It's the same as saying:
>
> ? ? depends on ARCH_OMAP2PLUS
> ? ? default y

Hm, somehow I've never encountered this syntax, but it more looks like
it means "default y if ARCH_OMAP2PLUS" instead of that.

Checked this with menuconfig now:
  default ARCH_OMAP2PLUS
resolves to:
  ARCH_HAS_CPUFREQ [=y] && CPU_FREQ [=y] && ARM [=y]

..which might cause build break when OMAP is not selected, and

  depends on ARCH_OMAP2PLUS
  default y
resolves to:
  ARCH_HAS_CPUFREQ [=y] && CPU_FREQ [=y] && ARM [=y] && ARCH_OMAP2PLUS [=y]

..which should be randconfig friendly.

-- 
Gra?vydas
