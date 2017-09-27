From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Sep 2017 14:39:32 +0100
Subject: [PATCH 3/3] arm64: cpuinfo: display product info in /proc/cpuinfo
In-Reply-To: <f09e55d8-28ba-30e3-d58a-ad125fd73019@arm.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170926222324.17409-4-ahs3@redhat.com>
 <f09e55d8-28ba-30e3-d58a-ad125fd73019@arm.com>
Message-ID: <20170927133931.GH32150@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 27, 2017 at 11:42:07AM +0100, Robin Murphy wrote:
> On 26/09/17 23:23, Al Stone wrote:
> > +			seq_printf(m, ", ARM 8.%d (r%dp%d) CPU",
> > +				   MIDR_VARIANT(midr),
> > +				   MIDR_VARIANT(midr),
> > +				   MIDR_REVISION(midr));
> 
> What is "ARM 8.1" meant to infer for, say, a typical Cortex-A57?

Just to make Robin's point a little clearer, MIDR_EL1.Variant is
IMPLEMENTATION DEFINED, and doesn't describe the ARMv8.x architecture
revision.

For example, on Cortex A57 is contains the major revision number of the
CPU, and is 1 for any r1pY Cortex-A57 (e.g. those on Juno R1).

For better or worse, the architecture provides us no mechanism to
determine the architecture revision.

Thanks,
Mark.
