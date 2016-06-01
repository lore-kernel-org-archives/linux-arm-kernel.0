From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 01 Jun 2016 20:48:31 +0200
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors
 variants
In-Reply-To: <7hy46oeusn.fsf@baylibre.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
 <574EB4A5.9000805@arm.com> <7hy46oeusn.fsf@baylibre.com>
Message-ID: <2913601.uXsaKdIlc0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 1. Juni 2016, 09:30:16 schrieb Kevin Hilman:
> [ + Heiko, who may know about the Rockchip implementation ]
>
> Sudeep Holla <sudeep.holla@arm.com> writes:
> > On 30/05/16 09:30, Neil Armstrong wrote:
> >> On 05/27/2016 10:17 AM, Neil Armstrong wrote:
> > [..]
> > 
> >> While looking for other ARMv8 based platform, I found that the RK3368
> >> platform has the same SCPI implementation as Amlogic.
> >> 
> >> They extended it with DDR, system and thermal commands.
> >> 
> >> Look at :
> >> https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/drivers/mailbo
> >> x/scpi_cmd.h>>
> >>https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/drivers/mailbox
> >>/scpi_protocol.c>>
> >> So the SCPI must have a framework to allow different protocol
> >> versions, and must allow command extension. Grouping Rockchip and
> >> Amlogic should be done, thus needing a generic name like vendor_scpi
> >> or with a version.
> > 
> > Makes sense. I understand the need to reuse and I need a bit of time to
> > have a look at the code(both Amlogic one's you have pointed out and the
> > Rockchip one) in detail to see what's the best way to proceed. I will
> > have a look at this later this week and get back to you.
> > 
> >> Sudeep, could you somehow find out which version of the protocol
> >> AmLogic and Rockchip based their SCPI development ?
> > 
> > Yes I tried checking with Rockchip but didn't get a response. But my
> > guess is that it was some preliminary unpublished version of SCPI
> > unfortunately :(

I only glanced a bit on the scpi stuff of the rk3368, but it seems you already 
found the rockchip implementation above.

The mailbox driver entered mainline recently, but I think it differs a bit 
from the one used there.

I've also added Caesar, who did the upstreaming of the mailbox driver, maybe 
he knows more about the scpi side as well.


Heiko
