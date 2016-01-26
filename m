From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jan 2016 11:09:27 +0000
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160126103200.GI6375@twins.programming.kicks-ass.net>
References: <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
 <20160126103200.GI6375@twins.programming.kicks-ass.net>
Message-ID: <20160126110053.GA21553@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 11:32:00AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 26, 2016 at 11:24:02AM +0100, Peter Zijlstra wrote:
> 
> > Yeah, this goes under the header: memory-barriers.txt is _NOT_ a
> > specification (I seem to keep repeating this).
> 
> Do we want this ?
> 
> ---
>  Documentation/memory-barriers.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index a61be39c7b51..433326ebdc26 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1,3 +1,4 @@
> +
>  			 ============================
>  			 LINUX KERNEL MEMORY BARRIERS
>  			 ============================
> @@ -5,6 +6,22 @@
>  By: David Howells <dhowells@redhat.com>
>      Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>  
> +==========
> +DISCLAIMER
> +==========
> +
> +This document is not a specification; it is intentionally (for the sake of
> +brevity) and unintentionally (due to being human) incomplete. This document is
> +meant as a guide to using the various memory barriers provided by Linux, but
> +in case of any doubt (and there are many) please ask.

It might be worth adding you and me to the top of the file, to save Paul
Cc'ing us on questions (get_maintainer.pl points at poor old Corbet for
this file).

But yes, it seems that something like this is required.

Will
