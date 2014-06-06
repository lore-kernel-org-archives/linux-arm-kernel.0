From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 6 Jun 2014 10:35:43 +0300
Subject: [PATCH v7 4/5] ARM: tegra: Add efuse and apbmisc bindings
In-Reply-To: <5390F55A.8090207@wwwdotorg.org>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-5-git-send-email-pdeschrijver@nvidia.com>
 <5390B9F3.8030108@wwwdotorg.org>
 <20140605221301.GQ5961@tbergstrom-lnx.Nvidia.com>
 <5390F55A.8090207@wwwdotorg.org>
Message-ID: <20140606073543.GT5961@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 12:55:22AM +0200, Stephen Warren wrote:
> On 06/05/2014 04:13 PM, Peter De Schrijver wrote:
> > On Thu, Jun 05, 2014 at 08:41:55PM +0200, Stephen Warren wrote:
> >> On 06/05/2014 07:09 AM, Peter De Schrijver wrote:
> >>> Add efuse and apbmisc bindings for Tegra20, Tegra30, Tegra114 and Tegra124.
> >>
> >>> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> >>
> >>> +	apbmisc at 70000800 {
> >>> +		compatible = "nvidia,tegra114-apbmisc", "nvidia,tegra20-apbmisc";
> >>
> >> Is the Tegra114 APBMISC register layout 100% a backwards-compatible
> >> superset of that in Tegra20? For both registers the code currently uses
> >> *and* all possible registers the code could ever use? Since the APB MISC
> >> is a bit of a dumping ground for random registers, that feels unlikely,
> >> but perhaps it's possible.
> > 
> > For all I can see it is. At least for the registers the kernel is likely to
> > use.
> 
> But that's ("At least for the registers the kernel is likely to  use")
> not how compatible values are defined. We need to explicitly look at all
> the registers and actively decide that it really is compatible in order
> to mark it so. If we don't want to do that, it's best just to use a
> separate compatible value for each SoC, and add a couple more entries
> into the match table.

All the other registers are for all I can see only useful in emulation
environments.

Cheers,

Peter.
