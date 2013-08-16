From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 16 Aug 2013 11:56:22 +0100
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <9E753731-852D-4F04-931B-112B589D9FFB@codeaurora.org>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <2CD735CE-3FCF-4AB5-89C0-D813ECD19F11@codeaurora.org>
 <520C9AEA.6030507@arm.com>
 <9E753731-852D-4F04-931B-112B589D9FFB@codeaurora.org>
Message-ID: <520E0556.5080702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

On 15/08/13 20:00, Kumar Gala wrote:
>
> On Aug 15, 2013, at 4:10 AM, Punit Agrawal wrote:
>
>>> What is the list of interrupts related to, should there be an associated interrupts-names
>>>
>>
>> For the CCI PMU, each interrupt signal corresponds to the overflow of a performance counter.
>>
>> Here again, I was trying to be robust in the face of differing hardware configurations - specially the scenario where multiple interrupt lines from the CCI PMU are tied together to generate a single interrupt to the CPU.
>
> Even in the case of multiple interrupt lines tied together, why wouldn't you still specify each interrupt specifier and they all just be the same and thus the interrupt appears to be shared ?
>

I am not quite sure what you are asking here. Are you suggesting that 
even if the interrupts are muxed, they should be specified multiple times?

Below is an update I've added to the documentation to better describe 
the interrupts. Does this help?

@@ -104,8 +103,19 @@ specific to ARM.
                 - interrupts:
                         Usage: required
                         Value type: <prop-encoded-array>
-                   Definition: comma-separated list of unique PMU
-                               interrupts
+                 Definition: comma-separated list of counter overflow
+                             interrupts.
+
+                             The CCI PMU has an interrupt signal for each
+                             counters. Typically, the number of
+                             interrupts will be equal to the number of
+                             counters.
+
+                             On some platforms, the individual interrupt
+                             signals may be combined in some fashion
+                             before being routed to the interrupt
+                             controller resulting in less number of
+                             interrupts than counters.

  * CCI interconnect bus masters


> - k
>
