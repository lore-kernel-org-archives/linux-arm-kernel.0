From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 8 Jun 2016 09:34:06 +0100
Subject: [RFC 1/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <1465333713-14339-2-git-send-email-jon.mason@broadcom.com>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
 <1465333713-14339-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <5757D87E.2080508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/06/16 22:08, Jon Mason wrote:
> Query the CPU core clock in the device tree to determine the core clock
> speed.

How do guarantee that it's the current frequency of the CPU ?
It doesn't even represent the mix or max frequency, so it's incorrect.
Some DTs have boot frequency in that entry.

> Output this clock rate in /proc/cpuinfo to match the output
> from other architectures.  The output is intentionally patterned after
> the x86 output, to match existing (and possibly expected) convention.
>
> If any errors are encountered in querying the clock (or the speed is
> erroneously zero), nothing will be printed out.  Thus any existing
> devices that do not have CPU clocks defined in the device tree will
> work as before.
>

What if they just don't have in DT but have DVFS support ?

Also whey do we need this support when the user-space can query the
CPUFreq sysfs which is more accurate and maintains the current running
frequency ?

-- 
Regards,
Sudeep
