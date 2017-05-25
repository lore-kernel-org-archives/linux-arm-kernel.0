From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 May 2017 10:24:46 -0700
Subject: [CFT] Always enable SMP mode on MP capable CPUs
In-Reply-To: <20170525165651.GK22219@n2100.armlinux.org.uk>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <828a8817-b18d-6945-f35e-115abf30fe17@gmail.com>
 <20170525165651.GK22219@n2100.armlinux.org.uk>
Message-ID: <0eac2f9f-8af7-b991-6021-320b91f3f98a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2017 09:56 AM, Russell King - ARM Linux wrote:
> On Thu, May 25, 2017 at 09:15:19AM -0700, Florian Fainelli wrote:
>> On 05/18/2017 03:52 AM, Russell King - ARM Linux wrote:
>>> As a result of a recent bug report, it has been found that certain CPUs
>>> must always have SMP mode enabled in order for the caches to work.
>>>
>>> Remove the conditional on setting the SMP bit(s).
>>>
>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>>> ---
>>> This needs to be tested on:
>>>
>>> - Cortex A5MP
>>> - Cortex A9MP
>>> - Cortex R7MP
>>> - Cortex A7MP
>>> - Cortex A12MP
>>> - Cortex A15MP
>>> - Cortex A17MP
>>> - Brahma B15
>>
>> Sorry just saw this, what kind of test do you want me to run on B15?
>> Should I build a !SMP kernel, or force a SMP kernel with maxcpus=1?
> 
> What I'm after is testing on any single-core systems with these SMP
> capable cores.  If the core never appears in a single-core configuration,
> then please let me know so it can be crossed off the list.

We have chips like the 7250 that are single core, and we do run a
CONFIG_SMP kernel on this guy as well. Feel free to add:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

on 7250 (single core), 7445 (core core) and 7278 (quad core Brahma B53
in 32-bit mode) as well. If you are curious about what we report, B15
report:

7250, 7445: CPU: ARMv7 Processor [420f00f3] revision 3 (ARMv7), cr=30c5387d
7278: CPU: ARMv7 Processor [420f1000] revision 0 (ARMv7), cr=30c5383d

> 
> With the bug that crept in fixed (as pointed out by Tony) there is no
> difference for kernels built with SMP enabled and detected as a SMP
> capable CPU.
> 

Got it, thanks!
-- 
Florian
