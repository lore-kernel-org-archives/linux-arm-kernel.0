From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 10 Sep 2013 22:04:42 +0530
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <Pine.LNX.4.64.1309101740120.16010@axis700.grange>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <CAKohponZ+FnzqXYMbBzbun0-1iQMi2fS4syrEBC_MdF41vLCeA@mail.gmail.com>
 <Pine.LNX.4.64.1309101656150.16010@axis700.grange>
 <CAKohpomBBKLhNemVUpUHAftGhPJJe+ZB7T_9UYLD7LwpR1nK0g@mail.gmail.com>
 <Pine.LNX.4.64.1309101740120.16010@axis700.grange>
Message-ID: <CAKohpomK7Y_6aLMA3B+hZrtgYq9U89ihgkbvYWA3BsKN3gJD3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 September 2013 21:52, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Of course, isn't that what I've written above? reverted a commit and added
> debug - in that order.

Ok, I misread it then :(

> Sure, I can... So, with the performance governor I get
>
> [    1.290000] cpufreq-cpu0 cpufreq-cpu0: Looking up cpu0-supply from device tree
> [    1.290000] cpufreq: trying to register driver generic_cpu0
> [    1.290000] cpufreq: adding CPU 0
> [    1.290000] cpufreq: Adding link for CPU: 1
> [    1.290000] cpufreq: setting new policy for CPU 0: 398667 - 1196000 kHz
> [    1.290000] cpufreq: new min and max freqs are 398667 - 1196000 kHz
> [    1.290000] cpufreq: governor switch
> [    1.290000] cpufreq: __cpufreq_governor for CPU 0, event 4
> [    1.290000] cpufreq: __cpufreq_governor for CPU 0, event 1
> [    1.290000] cpufreq_performance: setting to 1196000 kHz because of event 1
> [    1.290000] cpufreq: __cpufreq_driver_target().1665 1
>
> This is my debug - .transition_ongoing is incremented ^^^^^^^^
>
> [    1.300000] cpufreq: target for CPU 0: 1196000 kHz, relation 1, requested 1196000 kHz

Quite straight forward actually.. Please try attached patch and see if it fixes
your problem.. Which it should if I am not wrong.. I will send it
separately then..

Thanks for your time..
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fix-target.patch
Type: application/octet-stream
Size: 1710 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/a9e28bba/attachment-0001.obj>
