From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 18 Jan 2017 08:39:16 -0800
Subject: [PATCH 2/2] ARM: DTS: Fix register map for virt-capable GIC
In-Reply-To: <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
 <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <2cfdd977-5ee9-a66a-acaf-8a4213bdbc37@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/18/2017 2:53 AM, Marc Zyngier wrote:
> Since everybody copied my own mistake from the DT binding example,
> let's address all the offenders in one swift go.
>
> Most of them got the CPU interface size wrong (4kB, while it should
> be 8kB), except for both keystone platforms which got the control
> interface wrong (4kB instead of 8kB).
>
> In the couple of cases were I knew for sure what implementation
> was used, I've added the "arm,gic-400" compatible string. I'm 99%
> sure that this is what everyong is using, but short of having the
> TRM for all the other SoCs, I've let them alone.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

>  arch/arm/boot/dts/imx6ul.dtsi        | 4 ++--
>  arch/arm/boot/dts/keystone-k2g.dtsi  | 2 +-
>  arch/arm/boot/dts/keystone.dtsi      | 2 +-

For keystone bits,
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
