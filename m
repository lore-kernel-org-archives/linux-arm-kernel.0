From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 13 Oct 2017 08:39:09 -0500
Subject: [PATCH 0/3] arm64: cpuinfo: make /proc/cpuinfo more human-readable
In-Reply-To: <20170927103406.GC32150@leverpostej>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170927103406.GC32150@leverpostej>
Message-ID: <CAOZdJXUzo3JrHW1h6W3y3BnVq472NjPpaqTztzEODZnnMyvJRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 5:34 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Al,
>
> On Tue, Sep 26, 2017 at 04:23:21PM -0600, Al Stone wrote:
>> As ARMv8 servers get deployed, I keep getting the same set of questions
>> from end-users of those systems: what do all the hex numbers mean in
>> /proc/cpuinfo and could you make them so I don't have to carry a cheat
>> sheet with me all the time?
>
> I appreciate that /proc/cpuinfo can be opaque to end users, but I do not
> believe that this is the right solution to that problem.
>
> There are a number of issues stemming from the face that /proc/cpuinfo
> is ill-defined and overused for a number of cases. Changes to it almost
> certainly violate brittle de-facto ABI details people are relying on,
> and there's a very long tail on fallout resulting from this. In
> addition, many niceties come at an excessive maintenance cost, and are
> simply unreliable as an ABI.
>
> So, as with all other patches modifying /proc/cpuinfo, I must NAK this
> series.

Qualcomm Datacenter Technologies is very interested in seeing these
patches (or some variant of them) accepted.  Updates to /proc/cpuinfo
are long overdue, and I'm asking you to reconsider your objections.
We're willing to work with distro vendors to get this information
added to their products while upstream is left behind, but I hope that
won't be necessary.

I would even go so far as to say that we should be making
/proc/cpuinfo for ARM match the x86 output as closely as possible,
even using their terminology.  We should be providing information like
frequencies and product names.

Having a human-readable /proc/cpuinfo with extensive details of the
CPU spelled out is very useful, and Al's reasoning is valid.  The fact
that it's "fragile" is not as important as the fact that on x86,
/proc/cpuinfo is much more useful.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
