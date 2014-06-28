From: u-igbb@aetey.se (u-igbb at aetey.se)
Date: Sat, 28 Jun 2014 09:09:57 +0200
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627220400.GT32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627213743.GB16724@brightrain.aerifal.cx>
 <20140627220400.GT32514@n2100.arm.linux.org.uk>
Message-ID: <20140628070957.GK5343@example.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 11:04:00PM +0100, Russell King - ARM Linux wrote:
> The kuser page isn't going anywhere _except_ for one situation: where
> the system integrator has determined that they have built their
> userspace not to require the kuser helpers, and wish to have greater
> security and performance through doing so.

> If the userspace requires the kuser helpers, then the page *must* be
> provided by the kernel.
> 
> It is a system integrator/distro bug to provide a kernel with the kuser
> helpers disabled, but then to provide a libc which requires the page.
 ...
> The system integrator has a choice to make:
 [how to compile the kernel and the library]

I would like you to be aware that the assumed "system integrator/distro"
is not necessarily a single entity. Generally speaking it is different
parties who choose the kernel and the libc_s_ being used (note the plural).

Running statically linked binaries is not the only example of this.

Running applications from a global file system (where the shared
libraries being used are placed too) is what we do all the time.

We want the users to be able to run our software on all and any distros
(and they do). The common denominator is the Linux ABI against the
kernel. The more "locally defined" this ABI happens to be, the less
usable/useful it is.

This does not invalidate your point - of course the hardware
owner/administrator _may_ choose to render third-party applications
unusable on that hardware unit, that's fine.

But is he/she the same party as the "system integrator"? Not necessarily.

Regards,
Rune
