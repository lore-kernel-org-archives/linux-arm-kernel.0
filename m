From: cl@linux.com (Christopher Lameter)
Date: Tue, 31 Jul 2018 15:38:13 +0000
Subject: [PATCH v4 13/17] khwasan: add hooks implementation
In-Reply-To: <CACT4Y+Y=61VwwETQP3FwAN16ompSNJOCyDCG6Ew1Bm5f_Fe1Lw@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
 <09cb5553-d84a-0e62-5174-315c14b88833@arm.com>
 <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
 <8240d4f9-c8df-cfe9-119d-6e933f8b13df@virtuozzo.com>
 <CACT4Y+Y=61VwwETQP3FwAN16ompSNJOCyDCG6Ew1Bm5f_Fe1Lw@mail.gmail.com>
Message-ID: <01000164f0fd5abc-df9ea911-9701-498c-adce-9f833e6df3ed-000000@email.amazonses.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Jul 2018, Dmitry Vyukov wrote:

> > Actually you should do this for SLAB_TYPESAFE_BY_RCU slabs. Usually they are with ->ctors but there
> > are few without constructors.
> > We can't reinitialize or even retag them. The latter will definitely cause false-positive use-after-free reports.
>
> Somewhat offtopic, but I can't understand how SLAB_TYPESAFE_BY_RCU
> slabs can be useful without ctors or at least memset(0). Objects in
> such slabs need to be type-stable, but I can't understand how it's
> possible to establish type stability without a ctor... Are these bugs?
> Or I am missing something subtle? What would be a canonical usage of
> SLAB_TYPESAFE_BY_RCU slab without a ctor?

True that sounds fishy. Would someone post a list of SLAB_TYPESAFE_BY_RCU
slabs without ctors?
