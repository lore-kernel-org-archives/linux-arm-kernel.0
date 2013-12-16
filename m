From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Dec 2013 12:56:23 +0000
Subject: [PATCH 00/10] Support VGIC save/restore using device control API
In-Reply-To: <1386878149-13397-1-git-send-email-christoffer.dall@linaro.org>
References: <1386878149-13397-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <52AEF877.7080906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 12/12/13 19:55, Christoffer Dall wrote:
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
> purposes on real hardware, and we can reuse this interface for the
> VGIC.  The API is therefore based on the memory-mapped register accesses
> defined in the specs.  See the individual patches for details.
> 
> The patches are based on kvm-arm-next with the arch timers save/restore
> patches applied:
> git://git.linaro.org/people/cdall/linux-kvm-arm.git timer-migrate-v4
> 
> This patch series based on the above can be cloned from:
> git://git.linaro.org/people/cdall/linux-kvm-arm.git vgic-migrate-v4

I think this series is getting ready. I commented on a couple of issues
that can get fixed very quickly. Once they are fixed, we'll be able to
add them in the upcoming PR for 3.14.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
