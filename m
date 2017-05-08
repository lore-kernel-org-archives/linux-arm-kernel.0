From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 8 May 2017 14:23:34 +0200
Subject: [PATCH v7 09/24] KVM: arm64: vgic-its: Introduce migration ABI
 infrastructure
In-Reply-To: <1494084283-12723-10-git-send-email-eric.auger@redhat.com>
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-10-git-send-email-eric.auger@redhat.com>
Message-ID: <20170508122334.GD28342@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06, 2017 at 05:24:28PM +0200, Eric Auger wrote:
> We plan to support different migration ABIs, ie. characterizing
> the ITS table layout format in guest RAM. For example, a new ABI
> will be needed if vLPIs get supported for nested use case.
> 
> So let's introduce an array of supported ABIs (at the moment a single
> ABI is supported though). The following characteristics are foreseen
> to vary with the ABI: size of table entries, save/restore operation,
> the way abi settings are applied.
> 
> By default the MAX_ABI_REV is applied on its creation. In subsequent
> patches we will introduce a way for the userspace to change the ABI
> in use.
> 
> The entry sizes now are set according to the ABI version and not
> hardcoded anymore.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
Reviewed-by: Christoffer Dall <cdall@linaro.org>
