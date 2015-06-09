From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 9 Jun 2015 08:10:58 +0200 (CEST)
Subject: [PATCH v4 2/2] dma: Add Xilinx AXI Central Direct Memory Access
 Engine driver support
In-Reply-To: <557681A7.7080202@monstr.eu>
References: <1432228035-6569-1-git-send-email-appanad@xilinx.com>
 <1432290653.27695.97.camel@x220> <557681A7.7080202@monstr.eu>
Message-ID: <alpine.DEB.2.02.1506090808500.2069@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 9 Jun 2015, Michal Simek wrote:

> Hi Paul,
> 
> On 05/22/2015 12:30 PM, Paul Bolle wrote:
> > Again, just a nit: a license mismatch.
> > 
> > On Thu, 2015-05-21 at 22:37 +0530, Kedareswara rao Appana wrote:
> > 
> >> + * This program is free software: you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation, either version 2 of the License, or
> >> + * (at your option) any later version.
> > 
> >> +MODULE_LICENSE("GPL v2");
> > 
> > As I said in the message I sent a short while ago: here too I think that
> > either the comment at the top of this file or the ident used in the
> > MODULE_LICENSE() macro needs to change.
> 
> This is not just the problem with this driver but with others too.
> Have you sent any patch to add GPL v2+ to license.h?
> 
> Also sort of checking for this will be great. Julia?

If this requires checking the contents of comment, Coccinelle currently 
can't help with that.  Perhaps an idea would be to just do a grep on the 
file.  So if I find MODULE_LICENSE("GPL v2") and then grepping for "either 
vresion 2" gives success, then there is a problem?  It's obviously not 
foolproof, but perhaps it could be helpful.

julia
