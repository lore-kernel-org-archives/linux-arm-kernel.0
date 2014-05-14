From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 May 2014 15:34:48 +0100
Subject: [PATCHv2 3/4] ARM: mm: add support for HW coherent systems in
 PL310
In-Reply-To: <1399975839-5311-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140514143448.GD19866@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 11:10:38AM +0100, Thomas Petazzoni wrote:
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -8,6 +8,8 @@ Required properties:
>  
>  - compatible : should be one of:
>    "arm,pl310-cache"
> +  "arm,pl310-coherent-cache", used for I/O coherent platforms using
> +     the PL310 cache
>    "arm,l220-cache"
>    "arm,l210-cache"
>    "bcm,bcm11351-a2-pl310-cache": DEPRECATED by "brcm,bcm11351-a2-pl310-cache"

The binding name kind of implies that we have a transparent PL310 cache
(at least to me), which is not the case. I would rather have a specific
dma-coherent property or something similar since it's not another type
of PL310 but rather a different SoC topology.

But I recall you mentioned that you can't make this decision at the DT
level since you don't know before whether the SoC is I/O coherent or
not.

-- 
Catalin
