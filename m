From: mpeg.blue@free.fr (Mason)
Date: Thu, 15 Jan 2015 18:24:29 +0100
Subject: RFC on cpufreq implementation
Message-ID: <54B7F7CD.7030903@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a follow-up to my previous thread.
"How many frequencies would cpufreq optimally like to manage?"
http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669

As I originally wrote, I'm running 3.14 on an ARM Cortex-A9
based SoC (namely Tango4 from Sigma Designs). I'd like to get
some feedback on the cpufreq driver I wrote for that platform.

I decided to expose only a small subset of frequencies (namely
{999,500,333,111} MHz) because, in my tests, the ondemand gov
chose mostly min and max, and the intermediate frequencies not
so much; so I figured "2 intermediate freqs" is good enough.
(I'm ready to hear otherwise.)

I tried to use as much generic framework as possible, but I've
read about the clk framework, and it looks to be an even greater
generalization. Are new platforms encouraged to use that, rather
than provide a cpufreq driver? Does it work when voltage scaling
comes in play? (This SoC doesn't have it, but the next will.)

I'm also wondering how cpufreq and cpuidle interact? Is one a
subset of the other? Are they orthogonal?

Regards.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cpufreq.c
Type: text/x-csrc
Size: 2317 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/f2c475b8/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: temp.h
Type: text/x-chdr
Size: 466 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/f2c475b8/attachment-0001.bin>
