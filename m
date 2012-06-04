From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jun 2012 00:59:29 +0100
Subject: strongly ordered comment on device memory in mmu.c
In-Reply-To: <CAB9O=CMc7Lk0RCRL539qOGfx0nO6=JZp3gP1gL_HXvBzkxv3Ew@mail.gmail.com>
References: <CAB9O=CMc7Lk0RCRL539qOGfx0nO6=JZp3gP1gL_HXvBzkxv3Ew@mail.gmail.com>
Message-ID: <20120604235929.GA29501@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 03:16:31PM -0700, John Linn wrote:
> Hi,
> 
> We see that the following comment appears to be wrong in that the
> memory is device memory rather than strongly ordered memory.
> 
> ??????? [MT_DEVICE] = {?????????? /* Strongly ordered / ARMv6 shared device */
> 
> If it's really just a bad comment we'll do a patch, but I was
> wondering if there's more to it such that the comment is correct?

On pre-ARMv6, it's strongly ordered.  On post-ARMv6, it's "shared device".
The comment is accurate though possibly a little ambiguous; you're just
unaware of the history.
