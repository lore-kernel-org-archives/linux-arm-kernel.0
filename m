From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 28 Feb 2012 10:07:15 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <20120228094616.GA2063@linaro.org>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120227175327.GA2023@linaro.org>
 <1330372125.10008.47.camel@dagon.hellion.org.uk>
 <20120228094616.GA2063@linaro.org>
Message-ID: <1330423635.31269.40.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-28 at 09:46 +0000, Dave Martin wrote:
> On Mon, Feb 27, 2012 at 07:48:45PM +0000, Ian Campbell wrote:
> > Given that Stefano is proposing to make the ISS a (per-hypervisor)
> > constant we could consider just defining the Thumb and non-Thumb
> > constants instead of doing all the construction with the __HVC_IMM stuff
> > -- that would remove a big bit of the macroization.
> 
> It's not quite as simple as that -- emitting instructions using data
> directives is not endianness safe, and even in the cases where .long gives
> the right result for ARM, it gives the wrong result for 32-bit Thumb
> instructions if the opcode is given in human-readable order.

Urk, yes,..

> I was trying to solve the same problem for the kvm guys with some global
> macros -- I'm aiming to get a patch posted soon, so I'll make sure
> you're on CC.

Awesome, thanks!

Ian.
