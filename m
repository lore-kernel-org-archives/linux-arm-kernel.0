From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Oct 2015 13:06:28 +0100
Subject: [PATCH v2 5/5] drivers: firmware: psci: add PSCI v1.0 DT bindings
In-Reply-To: <56126379.6050201@arm.com>
References: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1436375811-10529-6-git-send-email-lorenzo.pieralisi@arm.com>
 <56126379.6050201@arm.com>
Message-ID: <20151005120628.GJ19064@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 12:48:09PM +0100, Andre Przywara wrote:
> Hi Lorenzo,
> 
> sorry for this late reply, but this came up recently during an IRC
> discussion:
> 
> On 08/07/15 18:16, Lorenzo Pieralisi wrote:
> > PSCI 1.0 is designed to be fully compliant to the PSCI 0.2
> > specification, with minor differences that are described in the
> > PSCI specification.
> 
> So if PSCI 1.0 is fully compliant to the 0.2 spec and PSCI 0.2 mandates
> a version function, why do we need a new binding here?

Some possible PSCI 1.0 implementations are not PSCI 0.2 compliant (e.g.
if they implement the new state parameter format). They would list
"arm,psci-1.0" only so old OSs wouldn't explode unexpectedly trying to
use not-quite-compatible features.

> IIRC device tree bindings are just for features that cannot be probed,
> whereas the availability of PSCI 1.0 features can be safely probed by
> issuing the PSCI_VERSION call and checking for bits [16:32] >= 1.
> So can't we just skip this extra binding and keep the compatible string
> to 0.2 for every upcoming PSCI implementation?

If PSCI 0.2 is reported in the DT, we can and will probe PSCI_VERSION to
detect PSCI 1.0 support, but the existing string implies true PSCI 0.2
compatibility.

> This should actually be the last binding we need, since availability of
> specific functions can be checked as well with the PSCI_FEATURES call in
> the future.

So long as the spec doesn't break compatibility in this fashion again,
yes. I certainly hope we don't have this problem again.

Mark.
