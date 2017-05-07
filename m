From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 14:12:25 +0100
Subject: [PATCH v7 19/24] KVM: arm64: vgic-its: Collection table
 save/restore
In-Reply-To: <1494084283-12723-20-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:38 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-20-git-send-email-eric.auger@redhat.com>
Message-ID: <878tm8kdza.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:38 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> The save path copies the collection entries into guest RAM
> at the GPA specified in the BASER register. This obviously
> requires the BASER to be set. The last written element is a
> dummy collection table entry.
>
> We do not index by collection ID as the collection entry
> can fit into 8 bytes while containing the collection ID.
>
> On restore path we re-allocate the collection objects.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
