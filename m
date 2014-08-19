From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Tue, 19 Aug 2014 11:46:21 -0500
Subject: [Linaro-acpi] [PATCH v2 06/18] ARM64 / ACPI: Parse MADT to map
 logical cpu to MPIDR and get cpu_possible/present_map
In-Reply-To: <53F32E3C.1070102@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-7-git-send-email-hanjun.guo@linaro.org>
 <53F24705.7080809@arm.com> <53F32E3C.1070102@linaro.org>
Message-ID: <CAMDttNf5d6XZ66mbiZivLmZQvcFv1mN1KKkN6TUQe_Z5VCu-1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hanjun,

On Tue, Aug 19, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Will INTERRUPT_CONTROLLER confuse people? There is only one GIC redistributor
> (some people regard it as interrupt controller) in ARM system, if we use
> INTERRUPT_CONTROLLER people will regard it as multi-redistributors in the
> system, I think GIC_CPU_INTERFACE would be better, what do you think?

I think you meant to say "one GIC _distributor_" (GICD) instead of
redistributor (GICR).
ACPI5.1 only describes one GICD per system, but we can most certainly
describe multiple GICRs.
For multi-cpu systems, you'll definitely see multiple GIC redistributors.
