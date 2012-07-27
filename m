From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 27 Jul 2012 10:00:53 +0100
Subject: [Xen-devel] [PATCH 02/24] xen/arm: hypercalls
In-Reply-To: <501176AF.3000607@cantab.net>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <501176AF.3000607@cantab.net>
Message-ID: <1343379653.6812.92.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-26 at 17:56 +0100, David Vrabel wrote:
> On 26/07/12 16:33, Stefano Stabellini wrote:
> > 
> > + * The hvc ISS is required to be 0xEA1, that is the Xen specific ARM
> > + * hypercall tag.
> 
> Is this number, 0xea1, assigned to Xen by some external body?

The value and semantics of the hvc instructions immediate operand is
entirely up to the hypervisor authors. We could have chosen 0 or some
random number, we went for the latter because it increases the chances,
by some tiny amount, that we won't clash with some other hypervisors ABI
which makes supporting "foreign" guests that bit easier should it even
come to it.

IOW it's arbitrary in the same way that a Linux system calls used to use
int 0x80.

Ian.
