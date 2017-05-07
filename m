From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 14:42:26 +0100
Subject: [PATCH v7 23/24] KVM: arm64: vgic-its: Fix pending table sync
In-Reply-To: <1494084283-12723-24-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:42 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-24-git-send-email-eric.auger@redhat.com>
Message-ID: <87o9v4iy0t.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:42 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> In its_sync_lpi_pending_table() we currently ignore the
> target_vcpu of the LPIs. We sync the pending bit found in
> the vcpu pending table even if the LPI is not targeting it.
>
> Also in vgic_its_cmd_handle_invall() we are supposed to
> read the config table data for the LPIs associated to the
> collection ID. At the moment we refresh all LPI config
> information.
>
> This patch passes a vpcu to vgic_copy_lpi_list() so that
> this latter returns a snapshot of the LPIs targeting this
> CPU and only those.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
