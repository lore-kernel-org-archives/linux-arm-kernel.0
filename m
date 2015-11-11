From: daniel@iogearbox.net (Daniel Borkmann)
Date: Wed, 11 Nov 2015 20:41:16 +0100
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111192352.GT17308@twins.programming.kicks-ass.net>
References: <56436420.9090401@iogearbox.net> <20151111162341.GN9562@arm.com>
 <20151111172659.GA86334@ast-mbp.thefacebook.com>
 <20151111.123548.1039494689070388545.davem@davemloft.net>
 <20151111175741.GR17308@twins.programming.kicks-ass.net>
 <20151111181132.GA90947@ast-mbp.thefacebook.com>
 <20151111183128.GS17308@twins.programming.kicks-ass.net>
 <56438DE7.4080300@iogearbox.net>
 <20151111192352.GT17308@twins.programming.kicks-ass.net>
Message-ID: <564399DC.6010209@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2015 08:23 PM, Peter Zijlstra wrote:
> On Wed, Nov 11, 2015 at 07:50:15PM +0100, Daniel Borkmann wrote:
>> Well, on that note, it's not like you just change the target to bpf in your
>> Makefile and can compile (& load into the kernel) anything you want with it.
>> You do have to write small, restricted programs from scratch for a specific
>> use-case with the limited set of helper functions and intrinsics that are
>> available from the kernel. So I don't think that "Programs that used to work
>> will now no longer work." holds if you regard it as such.
>
> So I don't get this argument. If everything is so targeted, then why are
> the BPF instructions an ABI.
>
> If OTOH you're expected to be able to transfer these small proglets,
> then too I would expect to transfer the source of these proglets.
>
> You cannot argue both ways.

Ohh, I think we were talking past each other. ;) So, yeah, you'd likely need
to add new intrinstics that then map to the existing BPF_XADD instructions,
and perhaps spill a warning when __sync_fetch_and_add() is being used to
advise the developer to switch to the new intrinstics instead. From kernel
ABI PoV nothing would change.
