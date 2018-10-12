From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Oct 2018 09:53:54 +0100
Subject: [PATCH v5 01/17] arm64: add pointer authentication register bits
In-Reply-To: <20181011162814.GC17000@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-2-kristina.martsenko@arm.com>
 <20181011162814.GC17000@arm.com>
Message-ID: <20181012085352.xi6rkcpm62iqd6ru@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 05:28:14PM +0100, Will Deacon wrote:
> On Fri, Oct 05, 2018 at 09:47:38AM +0100, Kristina Martsenko wrote:

> > +#define ESR_ELx_EC_PAC		(0x09)
> 
> Really minor nit: but shouldn't this be ESR_EL2_EC_PAC, since this trap
> can't occur at EL1 afaict?

It can also be taken to EL3 dependent on SCR_EL3.API.

We use ESR_ELx_EC_<foo> for other exceptions that can't be taken to EL1
(e.g. ESR_ELx_EC_SMC{32,64}), so I think it would be more consistent to
leave this as ESR_ELx_EC_PAC rather than ESR_EL2_EC_PAC.

Thanks,
Mark.
