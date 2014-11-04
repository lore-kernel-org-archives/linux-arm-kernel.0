From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Nov 2014 16:44:14 +0100
Subject: [PATCH v3 15/19] arm/arm64: KVM: add opaque private pointer to
 MMIO accessors
In-Reply-To: <1414776414-13426-16-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-16-git-send-email-andre.przywara@arm.com>
Message-ID: <20141104154414.GN16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:50PM +0000, Andre Przywara wrote:
> For a GICv2 there is always only one (v)CPU involved: the one that
> does the access. On a GICv3 the access to a CPU redistributor is
> memory-mapped, but not banked, so the (v)CPU affected is determined by
> looking at the MMIO address region being accessed.
> To allow passing the affected CPU into the accessors, extend them to
> take an opaque private pointer parameter.
> For the current GICv2 emulation we ignore it and simply pass NULL
> on the call.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Why does it have to be an opaque private pointer?  Would it not always
be a struct vcpu * or a vcpu_id then?

Thanks,
-Christoffer
