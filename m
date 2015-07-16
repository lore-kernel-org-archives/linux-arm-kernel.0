From: lkurusa@redhat.com (Levente Kurusa)
Date: Thu, 16 Jul 2015 03:45:10 -0400 (EDT)
Subject: [PATCH] arm: fault.c: fix unhandled page fault message
In-Reply-To: <20150715190819.GE7557@n2100.arm.linux.org.uk>
References: <1436974250-4999-1-git-send-email-lkurusa@redhat.com>
 <20150715190819.GE7557@n2100.arm.linux.org.uk>
Message-ID: <1497929123.7202925.1437032710479.JavaMail.zimbra@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

----- Original Message -----
> On Wed, Jul 15, 2015 at 05:30:50PM +0200, Levente Kurusa wrote:
> > Even if the signal was handled using signal(2) the message
> > would be printed. Fix that by checking whether the signal
> > is handled.
> 
> Why?

One of the reasons is that arm64 prints the same message only when the signal
is unhandled.

The other is the message saying "unhandled". :-)

But, don't get me wrong, I found the 'problem' by having a quick glimpse at the code
(even though I have a testcase now...), so if you think this is right this way,
then so be it.

> 
> Even if the application handles the signal, the point of this debugging is
> to have the kernel report the reason for the fault.
> 
> Just because the application has installed a SIGSEGV handler to print some
> nice "oops" message, and to cleanly shut down (eg, like Xorg) doesn't mean
> we should hide this debugging.  In fact, as such handlers generally get in
> the way of getting a decent dump from the application, having the kernel
> report this information is even more valuable in this situation.

I agree, but I find this being controlled by a kernel config option _and_ a
parameter makes it harder to use. Maybe we could switch to the sysctl,
"debug.exception-trace" like some other architectures do? What do you think?

Thanks,
    Levente
