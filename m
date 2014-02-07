From: nm@ti.com (Nishanth Menon)
Date: Fri, 7 Feb 2014 11:40:37 -0600
Subject: [PATCH v2 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
In-Reply-To: <CAGo_u6ofC4NNPiTNcSnXUvT3RZJo54=XyjetR-ok5hCBrVZkKg@mail.gmail.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
 <1391786342-11812-3-git-send-email-thomas.ab@samsung.com>
 <52F50698.4060305@arm.com> <52F509BD.70903@arm.com>
 <CAGo_u6raZY0sKdDn4d92SKpi=eqUpf23vW8K_bEi-v62V2jdPA@mail.gmail.com>
 <52F51888.5010608@arm.com>
 <CAGo_u6ofC4NNPiTNcSnXUvT3RZJo54=XyjetR-ok5hCBrVZkKg@mail.gmail.com>
Message-ID: <CAGo_u6pJtCe_j-xfO4wNHRHqdg4kC_1bsyfiFbHS2fuMiiY+2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 11:37 AM, Nishanth Menon <nm@ti.com> wrote:
> On Fri, Feb 7, 2014 at 11:31 AM, Sudeep Holla <Sudeep.Holla@arm.com> wrote:
>>
>> Yes I thought of exactly similar clock setup, but was not convinced that it
>> should be part of OPP. In that case it looks like we are trying to represent
>> clock internals through some OPP bindings.
>
> And this series (rightly) does not make it an OPP behavior. instead
> all it does is to list the boost-frequencies and mark those in cpufreq
> table. the description is left to the dts and implementation to the
> clock drivers involved.


One more thing, before I forget -> currently
dev_pm_opp_[init|free]_cpufreq_table is in drivers/base/power/opp.c ->
this probably should go away to drivers/cpufreq to keep opp.c
independent of frameworks using it. i dont see any code that is
introduced in the mentioned functions as being OPP behavior specific,
instead, I consider them as cpufreq+opp behaviors, which this change
fits into.

Regards,
Nishanth Menon
