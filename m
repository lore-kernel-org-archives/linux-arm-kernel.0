From: sebcape@gmail.com (Sebastian Capella)
Date: Wed, 18 Jun 2014 11:20:11 -0700
Subject: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
In-Reply-To: <20140618173648.GB31573@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
 <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
 <20140618173648.GB31573@e102568-lin.cambridge.arm.com>
Message-ID: <CAPd3N-9J7m_cqLgG0PgkGaZvnqSr9WrdOtWAC5_gA4_9qjSOfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 10:36 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Jun 13, 2014 at 06:33:35PM +0100, Nicolas Pitre wrote:
>> On Fri, 13 Jun 2014, Lorenzo Pieralisi wrote:
>>
>> > On Wed, Jun 11, 2014 at 07:15:16PM +0100, Nicolas Pitre wrote:
>> > >
>> > > ...__[EXEC]__|__[PREP]--|__[ENTRY]__|__[IDLE]__|___[EXIT]_--|__[EXEC]__...
>> > >              |          |           |          |            |
>> > >              |<-- entry-latency --->|
>> > >                                                |<- exit-  ->|
>> > >                                                |  latency   |
>> > >              |<-------------- min-residency --------------->|
>> > >                         |<----- worst_wakeup_latency ------>|
>> > >
>> > > entry-latency: Worst case latency required to enter the idle state.  The
>> > > exit_latency may be guaranteed only after entry-latency has passed.
>> > >
>> > > min-residency: Minimum period, including preparation, entry and exit,
>> > > for a given power mode to be worthwhile energy wise.  It must be at
>> > > least equal to entry_latency + exit_latency.
>
> Ok, a minor tweak to the diagram above, min-residency should include
> energy costs related to idle entry and exit, but not the exit-latency
> itself, as long as the energy costs implied by exiting the state are
> factored out in the min-residency-us property.

This makes sense to me..

It includes accounting for the energy cost vs WFI of prep/entry/exit,
but timing is from the end of the previous exec, until the event is
expected to trigger.

Thanks!

Sebastian
