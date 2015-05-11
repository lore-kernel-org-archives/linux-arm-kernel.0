From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 May 2015 13:39:54 +0100
Subject: [PATCH 05/12] arm64: psci: support unsigned return values
In-Reply-To: <20150511122525.GA2187@red-moon>
References: <1431085004-32743-1-git-send-email-mark.rutland@arm.com>
 <1431085004-32743-6-git-send-email-mark.rutland@arm.com>
 <20150511122525.GA2187@red-moon>
Message-ID: <20150511123954.GB4595@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 01:25:25PM +0100, Lorenzo Pieralisi wrote:
> On Fri, May 08, 2015 at 12:36:37PM +0100, Mark Rutland wrote:
> 
> [...]
> 
> > -static int psci_get_version(void)
> > +static u32 psci_get_version(void)
> >  {
> > -	int err;
> > -
> > -	err = invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
> > -	return err;
> > +	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
> >  }
> >  
> >  static int psci_cpu_suspend(struct psci_power_state state,
> > @@ -295,23 +292,13 @@ static int __init psci_probe(void)
> >  {
> >  	int ver = psci_get_version();
> 
> Is there a reason to keep ver as an int ?

No, I just missed it when propagating the type changes. It should be
corrected to a u32 as well.

> Other than that the patch looks fine.

Great!

Mark.
