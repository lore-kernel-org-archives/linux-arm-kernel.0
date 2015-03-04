From: joe@perches.com (Joe Perches)
Date: Wed, 04 Mar 2015 08:13:21 -0800
Subject: [PATCH 4.0-rc1 v17 4/6] printk: Simple implementation for NMI
 backtracing
In-Reply-To: <1425463974-23568-5-git-send-email-daniel.thompson@linaro.org>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-5-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1425485601.2712.9.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-03-04 at 10:12 +0000, Daniel Thompson wrote:
> Currently there is a quite a pile of code sitting in
> arch/x86/kernel/apic/hw_nmi.c to support safe all-cpu backtracing from NMI.
> The code is inaccessible to backtrace implementations for other
> architectures, which is a shame because they would probably like to be
> safe too.
> 
> Copy this code into printk. We'll port the x86 NMI backtrace to it in a
> later patch.

I think this would be better as a separate file
rather than increasing the bulk of printk.c
