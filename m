From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Apr 2013 11:16:30 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: R8A7779: add Ether support
In-Reply-To: <51702FAE.4040104@cogentembedded.com>
References: <201304042253.50662.sergei.shtylyov@cogentembedded.com>
 <20130418153611.GX14496@n2100.arm.linux.org.uk>
 <51702FAE.4040104@cogentembedded.com>
Message-ID: <20130419021630.GE25718@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 09:38:54PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 18-04-2013 19:36, Russell King - ARM Linux wrote:
> 
> >>+/* Ether */
> >>+static struct resource ether_resources[] = {
> >>+	{
> >>+		.start	= 0xfde00000,
> >>+		.end	= 0xfde003ff,
> >>+		.flags	= IORESOURCE_MEM,
> >>+	}, {
> >>+		.start	= gic_iid(0xb4),
> >>+		.flags	= IORESOURCE_IRQ,
> >>+	},
> 
> >There are macros for initializing these which have been around for a
> >few years now.
> 
>    I know, I know, just didn't know they're that old.
> 
> >Please consider using them in future.
> 
>    This file uses the old style resource intializers generally, it
> just needs wholesale conversion.

I'd be happy to review such a patch.
