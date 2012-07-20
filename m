From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Fri, 20 Jul 2012 11:27:36 +0000
Subject: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device
 tree data
In-Reply-To: <20120720095935.GQ4495@opensource.wolfsonmicro.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for the review.

On Fri, Jul 20, 2012 at 15:29:36, Mark Brown wrote:
> On Fri, Jul 20, 2012 at 12:16:26PM +0530, AnilKumar Ch wrote:
> 
> > +		vio_reg: regulator at 1 {
> > +			reg = <1>;
> > +			regulator-compatible = "vio";
> > +			regulator-min-microvolt = <1500000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> 
> Every regulator here has a rather large voltage range specified with no
> consumers added.  Are you sure these voltage ranges make sense in your
> design and you've not just cut'n'pasted the entire voltage range that
> your regulator supports without reference to what your board can do?
> 

tps65217.dtsi is a generic file to be used by the SoCs so these constraints
were taken from the regulator itself. SoC specific limits can be added in
SoC specific .dts file to tighten the constraints to require limit. I have
tested the driver with this approach.

Required consumers will be added while submitting the regulator dependent
Consumers. One of the usecase I can specify here is MPU voltage control
through DVFS framework. So if require, MPU consumer will be added along
with the DVFS support.

Thanks
AnilKumar
