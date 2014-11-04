From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Nov 2014 20:30:08 +0100
Subject: [PATCH v3 12/19] arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
In-Reply-To: <1414776414-13426-13-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-13-git-send-email-andre.przywara@arm.com>
Message-ID: <20141104193008.GO16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:47PM +0000, Andre Przywara wrote:
> vgic_set_attr() and vgic_get_attr() contain both code specific for
> the emulated GIC as well as code for the userland facing, generic
> part of the GIC.
> Split the guest GIC facing code of from the generic part to allow
> easier splitting later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

It's not really clear to me which data is specific to the emulated gic
and which is not or why you have to do this (yet), for example, the
_common function is now dealing with the GRP_ADDR case which is very
GICv2 specific (so far).  But I assume this will make sense as I
progress through the series.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
