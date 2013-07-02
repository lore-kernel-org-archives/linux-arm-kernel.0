From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 2 Jul 2013 16:41:01 +0900
Subject: [PATCH v2 0/2] ARM: shmobile: lager: Add DT reference
In-Reply-To: <1372645120-27256-1-git-send-email-horms+renesas@verge.net.au>
References: <1372645120-27256-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoSk2+mgkzOWZMsyDbJKYCS+Pp2cXMu4=SvO35EQ9sKtig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Jul 1, 2013 at 11:18 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi,
>
> this short series adds DT reference to Lager.

Thanks for your work on this.

> The intention of this is to allow the board to be
> brought up as much as possible using DT. And for
> this to act as a basis for further DT coverage
> of devices present on the Lager and its r8a7790 SoC.
>
>
> This series differs from v2 in that it has been
> rebased on top of reneas-next-20130701 and now makes use
> of r8a7790_init_delay().
>
>
> Simon Horman (2):
>   ARM: shmobile: r8a7790:  Initialise clocks and SCIF in
>     r8a7790_add_dt_devices()

At this point I'm inclined to say "no" to new DT reference using
platform devices for SCIF. I believe we instead should really work on
adding DT support to the SCIF driver and use DT for SCIF on more
recent boards. Also, we probably don't want to enable clocks like
that, instead we should tie in common clocks. That will take a little
bit longer time though, so I wonder what is a good solution until
then..

>   ARM: shmobile: lager: Add DT reference

I think you want to update Makefile.boot to include the
lager-reference board. Also, I believe that without SCIF and clocks
the init_machine() and init_irq() callbacks can be left unset to make
use of the default behaviour.

Cheers,

/ magnus
