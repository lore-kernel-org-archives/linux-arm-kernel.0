From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 16 Nov 2016 20:54:10 +0100
Subject: [PATCH v2] arm/arm64: KVM: VGIC: limit ITARGETSR bits to number
 of VCPUs
In-Reply-To: <20161116175716.31578-1-andre.przywara@arm.com>
References: <20161116175716.31578-1-andre.przywara@arm.com>
Message-ID: <20161116195410.GH3811@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 05:57:16PM +0000, Andre Przywara wrote:
> The GICv2 spec says in section 4.3.12 that a "CPU targets field bit that
> corresponds to an unimplemented CPU interface is RAZ/WI."
> Currently we allow the guest to write any value in there and it can
> read that back.
> Mask the written value with the proper CPU mask to be spec compliant.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
