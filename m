From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 25 Jan 2012 13:42:54 +0200
Subject: remoteproc: Load coprocessor code to the specific main memory
 location
In-Reply-To: <4F1EE861.4030405@monstr.eu>
References: <4F1EE861.4030405@monstr.eu>
Message-ID: <CAK=Wgba5kT8AwLtuHyosucYnWf-EA+xpE1kzmssfhSC7ZXQA=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Tue, Jan 24, 2012 at 7:20 PM, Michal Simek <monstr@monstr.eu> wrote:
> Hi,
>
> I have a question how to setup resource table to support firmware loading
> to specific memory location.
> I have allocated the part of ram which is at physical address 0x0
> which coprocessor needs for rtos code.

Can you specify about your allocation a bit more ? size ? method of
allocation (CMA/external ram+ioremap/other) ?

> Currently I am using carveout with setup size but from rproc_handle_carveout
> is __dma_alloc_buffer which is remapped by __dma_alloc_remap function to any

oh, so you're < ARMv6 (no CMA). you'd need to set aside some coherent
memory for your device then.

> Coprocessor can directly access memory of the main cpu.

That's fine: remoteproc supports these cases, and does not require an IOMMU.

We also successfully tested this with davinci, which does not have an IOMMU.

Looping in Mark, who did the davinci remoteproc support, and might
have the code available to share. Hopefully we'd have the patches
posted soon, and then no-iommu platforms could just use them for
reference.

Thanks,
Ohad.
