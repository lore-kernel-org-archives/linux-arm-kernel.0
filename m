From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 20 Jan 2015 12:31:13 +0000
Subject: [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
 and pass acpi=force to enable ACPI
In-Reply-To: <20150120111032.GB15924@leverpostej>
References: <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <20150119114255.GF11835@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8vPKAdsNg7QC7xW+i8_BemWEx4mvBx6NrnAHi8Y+bNtw@mail.gmail.com>
 <20150119135144.GI11835@e104818-lin.cambridge.arm.com>
 <20150119151350.21B65C40948@trevor.secretlab.ca>
 <54BD3803.6020307@redhat.com>
 <20150119175233.GK11835@e104818-lin.cambridge.arm.com>
 <20150119180122.GJ21553@leverpostej> <54BE1FEA.5040109@linaro.org>
 <20150120111032.GB15924@leverpostej>
Message-ID: <20150120123113.GP3827@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 11:10:32AM +0000, Mark Rutland wrote:
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 54e39e3..8268c7b 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -371,6 +371,31 @@ static void __init request_standard_resources(void)
> >   	}
> >   }
> > 
> > +int __init dt_scan_chosen(unsigned long node, const char *uname,
> > +			int depth, void *data)
> > +{
> > +	const char *p;
> > +	
> > +	if (depth != 1 || !data ||
> > +	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen at 0") != 0))
> > +		return 0;
> 
> Do we ever generate chosen at 0, and do we even accept that?

This probably originates from some stupid cargo-culting on my side,
based on some of the PPC-specific workarounds for old machines
remaining in drivers/of/*. It should go.

/
    Leif
