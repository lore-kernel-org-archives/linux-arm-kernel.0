From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 1 Jun 2013 15:15:26 +0530
Subject: [PATCH 07/15] cpufreq: spear needs cpufreq table
In-Reply-To: <2104181.OHBofkq3lH@wuerfel>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-8-git-send-email-arnd@arndb.de>
 <CAKohpomzoGsOoQ__fd0V651bjWt2=JTC10wGSQzX2yyTcWZmvA@mail.gmail.com>
 <2104181.OHBofkq3lH@wuerfel>
Message-ID: <CAKohponkPNBA2kWnpPyNmmJw2t03x63uUSbZkiDfUZzpqqxSKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2013 14:33, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 01 June 2013 07:28:01 Viresh Kumar wrote:
>> On 1 June 2013 03:52, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Like a lot of the other cpufreq drivers, this one needs to
>> > select CONFIG_CPU_FREQ_TABLE to avoid a build error like
>> >
>> > drivers/built-in.o: In function `spear_cpufreq_exit':
>> > spear-cpufreq.c:198: undefined reference to `cpufreq_frequency_table_put_attr'
>> > drivers/built-in.o: In function `spear_cpufreq_verify':
>> > spear-cpufreq.c:35: undefined reference to `cpufreq_frequency_table_verify'
>> > drivers/built-in.o: In function `spear_cpufreq_init':
>> > spear-cpufreq.c:181: undefined reference to `cpufreq_frequency_table_cpuinfo'
>> > spear-cpufreq.c:187: undefined reference to `cpufreq_frequency_table_get_attr'
>> > drivers/built-in.o: In function `spear_cpufreq_target':
>> > spear-cpufreq.c:120: undefined reference to `cpufreq_frequency_table_target'
>> > drivers/built-in.o:(.data+0x5e63c): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> > Cc: cpufreq at vger.kernel.org
>> > Cc: linux-pm at vger.kernel.org
>> > ---
>> >  drivers/cpufreq/Kconfig.arm | 1 +
>> >  1 file changed, 1 insertion(+)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> BTW, you want me to apply this one or take it through arm-soc tree?
>
> As I said in the introductory mail, I would prefer it if you
> can pick it up. Thanks!

I saw that mail later :(

Applied to cpufreq-next. Thanks.
