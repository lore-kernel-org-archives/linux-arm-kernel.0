From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 08 Apr 2017 11:42:27 +0100
Subject: [PATCH v4 08/22] KVM: arm64: ITS: Implement
 vgic_mmio_uaccess_write_its_iidr
In-Reply-To: <1490607072-21610-9-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Mon, 27 Mar 2017 11:30:58 +0200")
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
 <1490607072-21610-9-git-send-email-eric.auger@redhat.com>
Message-ID: <864lxzch9o.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27 2017 at 10:30:58 AM, Eric Auger <eric.auger@redhat.com> wrote:
> The GITS_IIDR revision field is used to encode the version of the
> table layout (ABI). So we need to restore it to check the table
> layout to be restored is compatible with the destination vITS.
>
> The user selected revision is stored in the user_revision field.
> It will be compared against the REV num at table restoration time.

Why isn't it sufficient to keep it GITS_IIDR RO and let userspace find
out about the ABI revision that the kernel understands?

Or are we planning on supporting multiple ABIs in the kernel? If so, do
we have a deprecation policy/plan? I don't mind either way, but it would
be good to document it...

Maybe it is documented already and I missed it (which is perfectly
possible!).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
