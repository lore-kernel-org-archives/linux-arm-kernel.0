From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:05:15 +0530
Subject: [PATCH v5 21/22] KVM: arm64: vgic-its: Fix pending table sync
In-Reply-To: <1492164934-988-22-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-22-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumdH=duE3qPqvH5yC2=Tvthk_dz4TqTaw-gy+oiZi9bYMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
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
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
