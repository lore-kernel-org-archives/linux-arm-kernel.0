From: Tim.Bird@sonymobile.com (Bird, Tim)
Date: Tue, 1 Oct 2013 18:04:29 +0200
Subject: Status of ARM FIQ?
In-Reply-To: <20131001092623.GA2640@localhost.localdomain>
References: <F5184659D418E34EA12B1903EE5EF5FD8538E865F6@seldmbx02.corpusers.net>,
 <20131001092623.GA2640@localhost.localdomain>
Message-ID: <F5184659D418E34EA12B1903EE5EF5FD8538E86602@seldmbx02.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 01, 2013 2:26 AM, Dave Martin [Dave.Martin at arm.com] wrote:
>On Mon, Sep 30, 2013 at 08:48:15PM +0200, Bird, Tim wrote:
>> I'm working through some proposals for contract work for the Consumer
>> Electronics Workgroup, and one of them involves use of ARM FIQ
>> as a debug activator.  I have heard a rumor that FIQ mode is not being
>> included in some modern ARM CPUs.
>>
>> Is there any truth to this?  Can someone give me a pointer to information
>> about this?
>
>All CPUs implement FIQ, except for the M-class CPUS in v7 onwards (which
>don't have an MMU, and thus could only run ucLinux).
>
>
>As to whether you can use FIQ, "it depends":
>
>Since the introduction of the Security Extensions in v6Z / v7,
>FIQ can be repurposed as a private interrupt for the Secure World, so
>if there is resident Secure World software, it may be impossible for
>Linux to use FIQ.
>
>Whether this does or doesn't apply depends on the SoC, and on how
>it has been integrated and set up.  Consumer device SoCs, especially
>anything coming to you via a mobile provider, will likely have this
>restriction.  Dev boards may be a bit more relaxed.

Ahh.  This is exactly the information I was looking for.  I think
this is what I heard about, but I mangled it in my mind.  (It was several
months ago that I heard something along these lines.)

>John Stultz has been working on the FIQ debugger for Android and may
>have some ideas.

The CE WG is considering sponsoring some work on the FIQ debugger, and
some Sony teams are still very interested in this getting mainlined all the way.
(though not the mobile phone team, for the reasons you mention - I'm pretty sure
that FIQ is not available to us in that product segment.)

Thanks very much for the info (to all who responded).

John,

Do you know the status of this?  Wasn't Anton Vorontsov working on this last year?
Does anyone know what the current status of that is?

 -- Tim
