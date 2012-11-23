From: rric@kernel.org (Robert Richter)
Date: Fri, 23 Nov 2012 15:10:25 +0100
Subject: [PATCH 1/1] ARM: oprofile: add A5/A7/A15 entries in op_perf_name
In-Reply-To: <20121120170817.GG27765@mudshark.cambridge.arm.com>
References: <1351853016-4476-1-git-send-email-jgq516@gmail.com>
 <20121105113102.GF3351@mudshark.cambridge.arm.com>
 <20121120121747.GJ2504@rric.localhost>
 <20121120155717.GD26475@mudshark.cambridge.arm.com>
 <20121120163158.GO2504@rric.localhost>
 <20121120165517.GC27765@mudshark.cambridge.arm.com>
 <20121120170601.GR2504@rric.localhost>
 <20121120170817.GG27765@mudshark.cambridge.arm.com>
Message-ID: <20121123141025.GG24690@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.12 17:08:17, Will Deacon wrote:
> > The advantage of a solution where userland updates cpu_type is that we
> > never need to update the kernel anymore. This means, cpu detection can
> > be part of the tools.
> 
> True, but the kernel-side perf code still needs updating to support the new
> CPU so I don't think you win much.

You also need perf support to use operf. If oprofile can update
cpu_type, the oprofile kernel interface would work for new hardware
without changes. We have support for both then, operf and opcontrol.

-Robert
