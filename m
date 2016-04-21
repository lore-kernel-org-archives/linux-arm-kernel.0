From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Apr 2016 12:44:16 +0100
Subject: [PATCH v7 17/16] arm64: hibernate: Refuse to hibernate if the
 boot cpu is offline
In-Reply-To: <1460565110-26341-1-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1460565110-26341-1-git-send-email-james.morse@arm.com>
Message-ID: <20160421114415.GJ6879@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 05:31:50PM +0100, James Morse wrote:
> It is important to hibernate/resume on the same CPU, otherwise we may
> change the cpu order or restore a big cpu's register state on a little
> cpu.
> 
> We know cpu 0 is the cpu the firmware booted us on last time, 

This assumes that we only kexec from CPU0 also, which we will have to
enforce. For example, disable_nonboot_cpus() does not enforce this if
CPU0 has been hotplugged out.

Otherwise, this kernel's CPU0 is not necessarily the CPU the FW booted
a kernel on.

Thanks,
Mark.
