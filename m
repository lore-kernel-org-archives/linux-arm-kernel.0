From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 28 Jun 2014 17:04:01 +0200
Subject: [PATCH 4/5] ARM: mvebu: Enable SCU Speculative linefills to L2
 for Armada 375/38x
In-Reply-To: <1403822608-31158-5-git-send-email-gregory.clement@free-electrons.com>
References: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
 <1403822608-31158-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140628170401.758c9d63@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 27 Jun 2014 00:43:27 +0200, Gregory CLEMENT wrote:

> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 8bb742fdf5ca..a24ea105e709 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -45,6 +45,7 @@ static void __init mvebu_scu_enable(void)
>  		of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>  	if (np) {
>  		scu_base = of_iomap(np, 0);
> +		scu_spec_linefills_enable(scu_base, true);

I find it rather weird to have a function call <foo>_enable() take a
boolean parameter to indicate whether <foo> should be enabled or
disabled. You should choose between:

	scu_spec_linefills_ctrl(scu_base, true/false)

(or some better suffix than _ctrl), or:

	scu_spec_linefills_enable(scu_base)
	scu_spec_linefills_disable(scu_base)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
