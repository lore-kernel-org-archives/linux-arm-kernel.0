From: agraf@suse.de (Alexander Graf)
Date: Fri, 16 Sep 2016 14:44:48 +0200
Subject: [PATCH v3 0/2] KVM: ARM: Enable vtimers with user space gic
In-Reply-To: <6b92c411-8b27-a4c0-6969-38e32bbf18ab@redhat.com>
References: <1474007187-18673-1-git-send-email-agraf@suse.de>
 <57DBC782.7080305@arm.com> <060ADA14-786E-400E-9B11-61C34B7081B5@suse.de>
 <20160916122937.GA14140@cbox>
 <6b92c411-8b27-a4c0-6969-38e32bbf18ab@redhat.com>
Message-ID: <10C5B047-6A7F-4255-BE56-5358AF88DA5E@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 16 Sep 2016, at 14:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> 
> 
> On 16/09/2016 14:29, Christoffer Dall wrote:
>>> It may be useful for migrating a gicv2 VM to a gicv3 host without gicv2 emulation as well.
>> 
>> I don't see why you'd do this; the VGIC hardware can perfectly well be
>> used for nesting as well, and this works rather well.
> 
> Can GICv3 emulate GICv2 in a guest?

It depends on the gicv3 configuration. As an SOC vendor you can either enable gicv2 compatibility or disable it. ThunderX for example is gicv3 only. LS2085 can handle gicv2 in the guest with gicv3 on the host.


Alex
