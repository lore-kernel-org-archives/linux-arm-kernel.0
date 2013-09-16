From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 16 Sep 2013 21:28:16 +0200
Subject: [PATCH v2 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <1379330464-27917-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1379330464-27917-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1379330464-27917-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <52375BD0.9030303@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/2013 13:21, Lorenzo Pieralisi wrote:
> In order to extend the current cpu nodes bindings to newer CPUs
> inclusive of AArch64 and to update support for older ARM CPUs this
> patch updates device tree documentation for the cpu nodes bindings.
> 
> Main changes:
>     - adds 64-bit bindings
>     - define usage of #address-cells
>     - defines behaviour on pre and post v7 uniprocessor systems
>     - adds ARM 11MPcore specific reg property definition
> 

For the Marvell (EBU) related part

Acked-by:Gregory CLEMENT <gregory.clement@free-electrons.com>

I would like to point that pj4b could be split in two flavors:
pj4b (currently used by Armada 370) and pj4b-mp (currently used
by Armada XP). The motivation for a such split would be for the errata
fix which can be different between pj4b and pj4b_mp. As we can
detect them at runtime, we don't need it from the device tree.
So we can live with a single pj4b binding.

Regards,


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
