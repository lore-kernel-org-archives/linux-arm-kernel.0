From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 10 Apr 2017 16:07:03 +0100
Subject: [PATCH v4 08/22] KVM: arm64: ITS: Implement
 vgic_mmio_uaccess_write_its_iidr
In-Reply-To: <74d62f62-c0eb-b7eb-4e3a-96b1b6d0d66d@arm.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
 <1490607072-21610-9-git-send-email-eric.auger@redhat.com>
 <864lxzch9o.fsf@arm.com>
 <5f1423fd-8f73-364a-9cf7-b4310957e2fd@redhat.com>
 <74d62f62-c0eb-b7eb-4e3a-96b1b6d0d66d@arm.com>
Message-ID: <CAFEAcA-dG-UuODon2c877m8oPdjSFfb9ZwHxUqDwSSiSXFMS8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2017 at 15:57, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 10/04/17 15:32, Auger Eric wrote:
>> Well this is partly documented in
>> Documentation/virtual/kvm/devices/arm-vgic-its.txt. No plan to
>> deprecate. migration from KVM supporting v1 to KVM supporting V2 would
>> be possible but not the contrary.
>>
>> Does it make sense?
>
> Sort of. Say you have three systems: A and C, which only supports v1; B,
> which supports v1 and v2. Let's say you migrate from A to B, and from B
> to C. Is B mandated to be able to export the tables as v1 and v2? Or can
> it restrict what it can export?

Generally for QEMU we only require forwards-compatibility (so
in this case old-kernel to new-kernel has to work but new-kernel
to old-kernel need not). Export-as-old-format if the in-kernel
data can be represented in the old format would be a nice to have
property only (and depending what the unanticipated future need
is, might not be possible at all).

The idea here is not that we expect to need this, but to give
ourselves an escape hatch for future use if we do find we need
to add something which won't fit in the currently defined format.

thanks
-- PMM
