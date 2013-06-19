From: horms@verge.net.au (Simon Horman)
Date: Wed, 19 Jun 2013 21:33:24 +0900
Subject: [PATCH 1/2] serial: sh-sci: HSCIF support
In-Reply-To: <CAO3366zWrYFYNaXNWpUvc8KpxjwYVoHz2O5fV33QFSTN2-H7aQ@mail.gmail.com>
References: <1371440327-30512-1-git-send-email-horms+renesas@verge.net.au>
 <1371440327-30512-2-git-send-email-horms+renesas@verge.net.au>
 <201306171454.48936.arnd@arndb.de>
 <20130618011901.GB2588@verge.net.au>
 <CAO3366zWrYFYNaXNWpUvc8KpxjwYVoHz2O5fV33QFSTN2-H7aQ@mail.gmail.com>
Message-ID: <20130619123324.GG32292@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 10:46:51AM +0200, Ulrich Hecht wrote:
> On Tue, Jun 18, 2013 at 3:19 AM, Simon Horman <horms@verge.net.au> wrote:
> >> This hunk causes build warnings in linux-next now:
> >>
> >> /git/arm-soc/drivers/tty/serial/sh-sci.c: In function 'sci_set_termios':
> >> /git/arm-soc/drivers/tty/serial/sh-sci.c:1942:37: warning: 'srr' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>     serial_port_out(port, HSSRR, srr | HSCIF_SRE);
> >>                                      ^
> >> /git/arm-soc/drivers/tty/serial/sh-sci.c:1892:15: note: 'srr' was declared here
> >>   unsigned int srr;
> >>                ^
> >> /git/arm-soc/drivers/tty/serial/sh-sci.c:1938:47: warning: 'cks' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>    serial_port_out(port, SCSMR, (smr_val & ~3) | cks);
> >>                                                ^
> >> /git/arm-soc/drivers/tty/serial/sh-sci.c:1890:40: note: 'cks' was declared here
> >>   unsigned int baud, smr_val, max_baud, cks;
> >
> > Ulrich, could you please look into this?
> 
> Hmmm... I get this warning with gcc 4.5, 4.6, and 4.8. Apparently gcc
> 4.7 is the only one that does not warn about this. Guess what I'm
> using... :(
> 
> This is of course trivially fixed, but I have completely lost track of
> the transmogrifications this patch has been subjected to. What's the
> procedure?

Hi Ulrich,

perhaps the best way forward would be for you to post an incremental patch
on top of either the sh-sci branch or renesas-next-20130618 tag of
my renesas tree on kernel.org.
