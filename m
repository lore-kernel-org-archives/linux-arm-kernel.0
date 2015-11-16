From: ian.campbell@citrix.com (Ian Campbell)
Date: Mon, 16 Nov 2015 09:42:57 +0000
Subject: [Xen-devel] [PATCH v4 2/7] xen/arm: introduce
 HYPERVISOR_platform_op on arm and arm64
In-Reply-To: <alpine.DEB.2.02.1511131757360.2653@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
 <1447349448-22610-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <5645E868.30706@citrix.com>
 <alpine.DEB.2.02.1511131757360.2653@kaball.uk.xensource.com>
Message-ID: <1447666977.15629.9.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-11-13 at 18:10 +0000, Stefano Stabellini wrote:
> 
> I agree with your point (I thought about it myself) but the current
> assembly scheme for hypercalls doesn't work well with that. I would have
> to introduce, and maintain going forward, two special hypercall
> implementations in assembly, one for arm and another for arm64, just to
> set interface_version. I don't think it is worth it; I prefer to have to
> maintain the explicit interface_version setting at the call sites (that
> today is just one).

You could give the bare assembly stub a different name (append _core or
_raw or something) and make HYPERVISOR_platform_op a C wrapper for it which
DTRT.

Ian.
