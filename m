From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Nov 2014 14:32:54 +0100
Subject: [PATCH v4 13/19] arm/arm64: KVM: split GICv2 specific emulation
 code from vgic.c
In-Reply-To: <1415959683-26027-14-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-14-git-send-email-andre.przywara@arm.com>
Message-ID: <20141123133254.GZ3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:07:57AM +0000, Andre Przywara wrote:
> vgic.c is currently a mixture of generic vGIC emulation code and
> functions specific to emulating a GICv2. To ease the addition of
> GICv3, split off strictly v2 specific parts into a new file
> vgic-v2-emul.c.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

[...]

> 
> -
> -void vgic_destroy(struct kvm_device *dev)
> -{
> -	kfree(dev);
> -}
> -
> -int vgic_create(struct kvm_device *dev, u32 type)

ah, I see, you make it static again when it magically apappears as vgic_v2_create.

never mind the comment on the last patch.

my ack still stands.

Thanks,
-Christoffer
