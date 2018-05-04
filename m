From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 4 May 2018 19:02:29 +0100
Subject: [PATCH 1/4] arm/arm64: smccc/psci: add arm_smccc_get_conduit()
In-Reply-To: <d04f8eff-06e3-2080-e03e-cd35b7b2c382@arm.com>
References: <20180503170330.5591-1-mark.rutland@arm.com>
 <20180503170330.5591-2-mark.rutland@arm.com>
 <d04f8eff-06e3-2080-e03e-cd35b7b2c382@arm.com>
Message-ID: <20180504180227.h6qt5u76eomxsw4s@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 06:54:14PM +0100, Robin Murphy wrote:
> On 03/05/18 18:03, Mark Rutland wrote:

> > We can kill off the PSCI_CONDUIT_* definitions once we've migrated users
> > over to the nerw interface.
> 
> new

Whoops; fixed locally.

[...]

> > +/**
> > + * arm_smccc_get_conduit()
> > + *
> > + * Returns the conduit to be used for SMCCCv1.1 or later.
> > + *
> > + * When SMCCCv1.1 is not present, returns SMCCC_CONDUIT_NONE.
> > + */
> > +enum arm_smccc_conduit arm_smccc_get_conduit(void);
> 
> Given that implicit condition, can we save some confusion by naming this
> arm_smccc_1_1_conduit(), in line with the actual SMCCCv1.1 calls?

Sure; done.

Thanks,
Mark.
