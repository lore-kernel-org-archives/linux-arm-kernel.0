From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 13 Nov 2017 17:56:14 +0000
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <20171113161445.xfqyuntza76ckdmq@hawk.localdomain>
References: <20171019145807.23251-1-james.morse@arm.com>
 <5A049B20.6000501@arm.com> <20171113112946.GK14144@cbox>
 <20171113161445.xfqyuntza76ckdmq@hawk.localdomain>
Message-ID: <CAFEAcA-uS0gyKHTvNxdTihoi37D=6jCTwzUTjFQttR=mivheBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2017 at 16:14, Andrew Jones <drjones@redhat.com> wrote:
> On Mon, Nov 13, 2017 at 12:29:46PM +0100, Christoffer Dall wrote:
>> I'm thinking this is analogous to migrating a VM that uses an irqchip in
>> userspace and has set the IRQ or FIQ lines using KVM_IRQ_LINE.  My
>> feeling is that this is also not supported today.
>
> Luckily userspace irqchip is mostly a debug feature, or just to support
> oddball hardware. Or at least that's the way I see its usecases...

True, but I think we should always insist on migration working
for new features, because it's just an easier line to define;
otherwise we end up with an annoying "feature mostly works,
unless you happened to be using [list of random things], in
which case it silently doesn't" effect.

thanks
-- PMM
