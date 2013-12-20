From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 11:25:43 +0100
Subject: [PATCH 01/10] ARM: tegra: Add AS3722 PMIC on Venice2
In-Reply-To: <52B3E968.8090906@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-2-git-send-email-treding@nvidia.com>
 <52B355EC.9040306@wwwdotorg.org> <52B3E968.8090906@nvidia.com>
Message-ID: <20131220102542.GJ27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 12:23:28PM +0530, Laxman Dewangan wrote:
> On Friday 20 December 2013 01:54 AM, Stephen Warren wrote:
> >On 12/19/2013 09:06 AM, Thierry Reding wrote:
> 
> >(Laxman, as an aside, I'm not sure why you're upstreaming patches that
> >don't exactly match the existing kernel support for this board...)
> 
> I did not get this based on what context it is. Can you please elaborate
> where I am missing the stuff?
> 
> 
> >
> >>diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
> >>+				sd0 {
> >>+					regulator-name = "vdd_cpu";
> >>+					regulator-min-microvolt = <700000>;
> >>+					regulator-max-microvolt = <1350000>;
> >Laxman's patch has:
> >
> >  					regulator-max-microvolt = <1400000>;
> 
> We have the Laguna platform on which Android and L4T is running fine. This
> is based on same PMIC used for Venice2. As we are running the more cpu
> stress on Laguna, I took this parameter from the Laguna Power tree where it
> is maximum 1.4V. Chrome have maximum as 1.35mV.

Whether this is used on Android, ChromeOS or L4T doesn't matter at all.
It specifies hardware constraints and thus must be agnostic of the OS
and workload.

Also this file describes the power tree for Venice2, so using values
from Laguna is wrong, no matter how similar they are.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/3c9b9058/attachment.sig>
