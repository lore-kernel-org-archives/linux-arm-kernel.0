From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Nov 2016 18:33:28 +0100
Subject: [PATCH 8/9] arm64: tegra: Enable PSCI on P3310
In-Reply-To: <786f354d-a1f2-f2c6-fde7-7b1af3df756c@arm.com>
References: <20161117171131.20062-1-thierry.reding@gmail.com>
 <20161117171131.20062-8-thierry.reding@gmail.com>
 <786f354d-a1f2-f2c6-fde7-7b1af3df756c@arm.com>
Message-ID: <20161117173328.GB7915@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 05:21:34PM +0000, Sudeep Holla wrote:
> 
> 
> On 17/11/16 17:11, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The P3310 processor module comes ships with a firmware that implements
> > PSCI 1.0. Enable and use it to bring up all CPUs.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 36 ++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> > index 807af7b68761..2c158c6809a5 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> > @@ -26,7 +26,43 @@
> >  		status = "okay";
> >  	};
> > 
> > +	cpus {
> > +		cpu at 0 {
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu at 1 {
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu at 2 {
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu at 3 {
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu at 4 {
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu at 5 {
> > +			enable-method = "psci";
> > +		};
> > +	};
> > +
> >  	bpmp {
> >  		status = "okay";
> >  	};
> > +
> > +	psci {
> > +		compatible = "arm,psci-1.0";
> > +		status = "okay";
> > +		method = "smc";
> 
> [...]
> 
> > +
> > +		cpu_off = <0x84000002>;
> > +		cpu_on = <0xc4000003>;
> > +		cpu_suspend = <0xc4000001>;
> 
> These are applicable only for "arm,psci"(i.e. PSCI v0.1), so you need to
> drop them.

Oh, indeed. I obviously skipped the arm,psci and arm,psci-0.2 entries in
the binding documentation and then assumed the optional properties
applied regardless of PSCI version.

Removed these and everything still works as expected.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161117/e20a846e/attachment.sig>
