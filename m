From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:01:16 +0530
Subject: [PATCH v5 14/22] KVM: arm64: vgic-its:
 KVM_DEV_ARM_ITS_SAVE/RESTORE_TABLES
In-Reply-To: <1492164934-988-15-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-15-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumdhxZca+mRNvg9i8TXNWBeSMh-VgAuaskvK0sLkeiRdGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> Introduce new attributes in KVM_DEV_ARM_VGIC_GRP_CTRL group:
> - KVM_DEV_ARM_ITS_SAVE_TABLES: saves the ITS tables into guest RAM
> - KVM_DEV_ARM_ITS_RESTORE_TABLES: restores them into VGIC internal
>   structures.
>
> We hold the vcpus lock during the save and restore to make
> sure no vcpu is running.
>
> At this stage the functionality is not yet implemented. Only
> the skeleton is put in place.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
