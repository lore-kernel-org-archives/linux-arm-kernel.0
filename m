From: agraf@suse.de (Alexander Graf)
Date: Sun, 25 Aug 2013 16:24:46 +0100
Subject: [PATCH 0/8] Support VGIC save/restore using device control API
In-Reply-To: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
References: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <28E10D53-3AE1-4E34-B6DE-351C2862C4D1@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23.08.2013, at 20:19, Christoffer Dall wrote:

> Implement save/restore of the VGIC state using the newer KVM Device
> Control API.  This requries some number of changes to existing code in
> addition to actually supporting save/restore of the necessary state.
> 
> The first patches (01-03) support creating the VGIC using the Device
> Control API.  This change is necessary because there are no other
> suitable KVM APIs that we can leverage to access the VGIC state from
> user space and the device control API was crafted exactly for this
> purpose.
> 
> Subsequent patches add the missing infrastructure and user space API
> pieces necessary to actually save and restore the VGIC state.  The GIC
> v2.0 architecture specification already specifies registers that can be
> used to save and restore the complete VGIC state for suspend/resume
> purposes on real hardware, and we can resuse this interface for the
> VGIC.  The API is therefore based on the memory-mapped register accesses
> defined in the specs.  See the individual patches for details.
> 
> The patches rely on a number of small fixes sent separately to actually
> work:
> git://git.linaro.org/people/cdall/linux-kvm-arm.git vgic-migrate-prereq
> 
> This patch series based on the above can be cloned from:
> git://git.linaro.org/people/cdall/linux-kvm-arm.git vgic-migrate
> 
> User space patches for QEMU will follow shortly.  Tested on Versatile
> Express TC2.

Looks quite straight forward and nice.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
