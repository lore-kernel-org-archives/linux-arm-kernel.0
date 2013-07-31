From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 31 Jul 2013 09:57:12 +0100
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <51F8153C.8030503@gmail.com>
References: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
 <51F7B4C9.2060500@gmail.com>
 <20130730125650.GD28716@e106331-lin.cambridge.arm.com>
 <20130730134427.GE28716@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307301528540.4893@kaball.uk.xensource.com>
 <51F8153C.8030503@gmail.com>
Message-ID: <1375261032.32691.95.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-30 at 14:34 -0500, Rob Herring wrote:

> I can think of lots of ways it would be cleaner, but that is not what
> ARM defined. There are 3 cases to handle: 32-bit only calls, 64-bit only
> calls and both 32/64-bit calls. I think hypervisors have the same issue
> as firmware. Do you know the guest is 32 or 64 bit up front and can
> provide it a dtb based on that?

Yes. An EL cannot change its own bit width and needs to rely on the EL
above returning in the right mode. IOW a hypervisor needs to know if it
is launching a 32- or 64-bit guest already.

I suppose in theory we could supply a mode switch hypercall, but we
don't and I think that is rather out of scope here...

Ian.
