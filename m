From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 May 2018 15:51:37 +0100
Subject: [PATCH 0/4] arm64: SMCCC conduit cleanup
In-Reply-To: <20180503170330.5591-1-mark.rutland@arm.com>
References: <20180503170330.5591-1-mark.rutland@arm.com>
Message-ID: <20180523145137.GB2983@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 06:03:26PM +0100, Mark Rutland wrote:
> Currently, the cpu errata code goes digging into PSCI internals to
> discover the SMCCC conduit, using the (arguably misnamed) PSCI_CONDUIT_*
> definitions. This lack of abstraction is somewhat unfortunate.
> 
> Further, the SDEI code has an almost identical set of CONDUIT_*
> definitions, and the duplication is rather unfortunate.
> 
> Let's unify things behind a common set of SMCCC_CONDUIT_* definitions,
> and expose the SMCCCv1.1 conduit via a new helper that hides the PSCI
> driver internals.

For the series:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
