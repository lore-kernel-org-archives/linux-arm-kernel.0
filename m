From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 20 Jan 2015 12:49:15 +0530
Subject: [PATCHv3 2/8] devfreq: exynos: Add documentation for generic
 exynos memory bus frequency driver
In-Reply-To: <CAL_Jsq+5sdsm_-VW-ta+qV-NBao-XTHvsYWcbMdZmbP0Nw43Cw@mail.gmail.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
 <1420681257-3078-3-git-send-email-cw00.choi@samsung.com>
 <CAL_Jsq+5sdsm_-VW-ta+qV-NBao-XTHvsYWcbMdZmbP0Nw43Cw@mail.gmail.com>
Message-ID: <CAKohpomqosqxeDANC=NLBVmOUHyUoqd7Zhph7r6f7+ufYN48EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2015 at 02:48, Rob Herring <robherring2@gmail.com> wrote:
> Adding Viresh.

Sorry for being too late, I was very busy with other cpufreq stuff I was doing
and saved this thread for later as it required me to understand it properly..

>> +Required properties for memory bus block:
>> +- clock-names : the name of clock used by the memory bus, "memory-bus".
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- #clock-cells: should be 1.
>> +- frequency: the frequency table to support DVFS feature.
>
> So you have just defined a new OPP table format. We already have one
> and Viresh is working to create a more extendable one. He asked about
> what's needed in devfreq, so Viresh here you go. :)

I failed to understand what's new here, probably I need more clarity on
what we are doing here..

So, this is what I see from OPPs point of view, everything else stripped out.

>> +       memory_bus_int: memory_bus at 1 {

>> +               operating-points = <
>> +                       400000 950000
>> +                       200000 950000
>> +                       133000 925000
>> +                       100000 850000
>> +                       80000  850000
>> +                       50000  850000>;

So these are the OPPs your "groups" support and below ones are
the frequencies that each block will support. Right ?

>> +               blocks {

>> +                               frequency = <
>> +                                       100000
>> +                                       100000
>> +                                       100000
>> +                                       100000

Why this replication here ?

>> +                                       50000
>> +                                       50000>;
>> +                       };

How are the above two tables (operating-points and frequency) related
here? What about the voltages at which these frequencies are possible ?

>> +                       display_block: memory_bus_block2 {

>> +                               frequency = <
>> +                                       200000
>> +                                       160000
>> +                                       100000
>> +                                       80000
>> +                                       80000
>> +                                       50000>;
>> +                       };

>> +                       isp_block: memory_bus_block3 {

>> +                               frequency = <
>> +                                       200000
>> +                                       200000
>> +                                       100000
>> +                                       80000
>> +                                       50000
>> +                                       50000>;
>> +                       };

>> +                       gps_block: memory_bus_block4 {

>> +                               frequency = <
>> +                                       300000
>> +                                       200000
>> +                                       133000
>> +                                       100000
>> +                                       50000
>> +                                       50000>;
>> +                       };

same for others as well..
