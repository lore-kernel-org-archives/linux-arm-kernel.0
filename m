From: a.spyridakis@virtualopensystems.com (Alexander Spyridakis)
Date: Tue, 2 Sep 2014 10:28:00 +0200
Subject: [Linaro-acpi] [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific
 ACPI boot support
In-Reply-To: <5404AE56.80801@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
 <5404AE56.80801@arm.com>
Message-ID: <CAJRNFKKziDydj_HFPam6e+FSZr6D3XPUQ+-iuH0a1Bbh3+Kz3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2014 19:35, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 01/09/14 15:57, Hanjun Guo wrote:
> > From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >
> > ACPI kernel uses MADT table for proper GIC initialization. It needs to
> > parse GIC related subtables, collect CPU interface and distributor
> > addresses and call driver initialization function (which is hardware
> > abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> >
> > NOTE: This commit allow to initialize GICv1/2 only.
>
> I cannot help but notice that there is no support for KVM here. It'd be
> good to add a note to that effect, so that people do not expect
> virtualization support to be working when booting with ACPI.

Just a heads up for this, I run up to this problem too while testing
and by forcing some values for vgic and arch_timers I could boot a
QEMU guest without problems.

I'll try and see if it will be easy to handle this more properly
instead of hardcoded values.

Regards.
