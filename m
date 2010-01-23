From: shivdas.tech@gmail.com (Shivdas Gujare)
Date: Fri, 22 Jan 2010 23:31:43 -0800
Subject: measureing kernel & application boottime's
Message-ID: <cf70f0211001222331y17af1f56oe7d4e61c1d38d7d3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim/all,

I am trying to measure kernel boottime along with measuring
application process start time on ARM V6 platform.
Because of few reasons, I have to stick to kernel 2.6.25(can't upgrade
it to latest).

While measuring application process times, I use "cat /proc/uptime"
when I start a process (I am not sure, if this is the best way to
measure time , please suggest if any).
For kernel, I use CONFIG_PRINTK_TIME macro. my application loads a
kernel module.
So, my question is how "/proc/uptime" relates to PRINTK_TIME timestamps?

I see, "uptime" uses
        do_posix_clock_monotonic_gettime(&uptime);
        monotonic_to_bootbased(&uptime);

while PRINTK_TIME does only, "cpu_clock(printk_cpu); "
but I am not able to understand practical difference between above two logics.

So, how do I correlate the time information from kernel dmesg , when
kernel module is loaded by my application(i.e. uptime measures just
before starting an application which loads kernel module).

Also, Is there any best method to measure application start time
(except bootchart, can't use it)?
Thanks for all your help.


Thanks and Regards,
Shivdas Gujare
