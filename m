From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Jan 2015 13:21:45 +0100
Subject: [PATCH v7 15/20] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <1421253084-9663-16-git-send-email-andre.przywara@arm.com>
References: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
 <1421253084-9663-16-git-send-email-andre.przywara@arm.com>
Message-ID: <20150115122145.GU26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 04:31:19PM +0000, Andre Przywara wrote:
> With everything separated and prepared, we implement a model of a
> GICv3 distributor and redistributors by using the existing framework
> to provide handler functions for each register group.
> 
> Currently we limit the emulation to a model enforcing a single
> security state, with SRE==1 (forcing system register access) and
> ARE==1 (allowing more than 8 VCPUs).
> 
> We share some of the functions provided for GICv2 emulation, but take
> the different ways of addressing (v)CPUs into account.
> Save and restore is currently not implemented.
> 
> Similar to the split-off of the GICv2 specific code, the new emulation
> code goes into a new file (vgic-v3-emul.c).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>


Drum roll....

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
