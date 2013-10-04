From: olof@lixom.net (Olof Johansson)
Date: Thu, 3 Oct 2013 19:53:51 -0700
Subject: [PATCH 038/228] cpufreq: sa11x0: Expose frequency table
In-Reply-To: <e689bd437918e56ae50541a90a4b9c606bfb8bf4.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <e689bd437918e56ae50541a90a4b9c606bfb8bf4.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <CAOesGMjE9s4KqHaAbkejZ-2GG4zv4Y1AxpgWzcMKovuMJFZ_-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 5:59 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch exposes sa11x0's frequency table to cpufreq core. It always existed
> but not as an array frequencies and not in the format cpufreq core wants it to.
> Also it was present in the unit of 100kHz earlier which is made consistent with
> cpufreq core now, i.e. kHz.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This causes breakage in linux-next for any SA1100 target:

In file included from ../../arch/arm/mach-sa1100/irq.c:24:0:
../../arch/arm/mach-sa1100/generic.h:24:39: error: array type has
incomplete element type
 extern struct cpufreq_frequency_table sa11x0_freq_table[];

-Olof
