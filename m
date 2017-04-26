From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:05:47 +0530
Subject: [PATCH v5 22/22] KVM: arm64: vgic-v3:
 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES
In-Reply-To: <1492164934-988-23-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-23-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumdp33HYaidM9BEmV42+T7Os3CttBCNL7gei-jK0vSPSAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> This patch adds a new attribute to GICV3 KVM device
> KVM_DEV_ARM_VGIC_GRP_CTRL group. This Allows the userspace to
> flush all GICR pending tables into guest RAM. At the moment
> we do not offer any restore control as the sync is implicit.
>
> As we need the PENDBASER_ADDRESS() in vgic-v3, let's move its
> definition in the irqchip header. We restore the full length
> of the field, ie [51:16]. Same for PROPBASER_ADDRESS with full
> field length of [51:12].
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
