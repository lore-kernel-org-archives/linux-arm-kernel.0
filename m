From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 May 2014 18:44:46 +0530
Subject: [PATCH v4 7/8] ARM: Exynos: switch to using generic cpufreq-cpu0
 driver
In-Reply-To: <1480209.xTrtNKOy7N@phil>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <6835645.2kTGeWTa9p@wuerfel>
 <CAKohpom_zuQoJ9xABJ2nJGbrubR=_iuE7_EtY6b41mhuhEtMsg@mail.gmail.com>
 <1480209.xTrtNKOy7N@phil>
Message-ID: <CAKohpo=mL4Wd3wajXQHnYW463-L1=QX=5krpPhOJ=NYet3xXoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 18:41, Heiko St?bner <heiko@sntech.de> wrote:
> Am Mittwoch, 14. Mai 2014, 18:35:29 schrieb Viresh Kumar:
>> On 14 May 2014 18:20, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Could we please come up with a way to probe this from DT in the
>> > cpufreq-cpu0 driver itself, so we don't have to add a device in every
>> > platform using it?

>> Its followed that way because DT Maintainers had strong objections
>> to creating virtual device nodes and haven't allowed creation of nodes
>> for cpufreq drivers.. For which there is no physical device, as CPU already
>> has a separate node..
>
> as we already have the "enable-method" property for enabling/disabling cpus,
> would something like a "scaling-method" be feasible?

Lets see what DT maintainers have to say on this, I would rather go for a
more straight forward name: "scaling-driver" :) ..
