From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 28 Feb 2012 12:21:37 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <20120228094616.GA2063@linaro.org>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120227175327.GA2023@linaro.org>
 <1330372125.10008.47.camel@dagon.hellion.org.uk>
 <20120228094616.GA2063@linaro.org>
Message-ID: <alpine.DEB.2.00.1202281131550.23091@kaball-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Feb 2012, Dave Martin wrote:
> > Given that Stefano is proposing to make the ISS a (per-hypervisor)
> > constant we could consider just defining the Thumb and non-Thumb
> > constants instead of doing all the construction with the __HVC_IMM stuff
> > -- that would remove a big bit of the macroization.
> 
> It's not quite as simple as that -- emitting instructions using data
> directives is not endianness safe, and even in the cases where .long gives
> the right result for ARM, it gives the wrong result for 32-bit Thumb
> instructions if the opcode is given in human-readable order.
> 
> I was trying to solve the same problem for the kvm guys with some global
> macros -- I'm aiming to get a patch posted soon, so I'll make sure
> you're on CC.
 
That would be great, thanks!
