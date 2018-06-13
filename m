From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 Jun 2018 14:48:50 +0200
Subject: [PATCH v1 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <CAA+hA=RpoRXUK+jB18F4OeYE9PG73SDa_NLYeN5Q2G3B1bC-JA@mail.gmail.com>
References: <20180601065821.28234-1-o.rempel@pengutronix.de>
 <20180601065821.28234-5-o.rempel@pengutronix.de>
 <CAA+hA=RpoRXUK+jB18F4OeYE9PG73SDa_NLYeN5Q2G3B1bC-JA@mail.gmail.com>
Message-ID: <20180613124850.w3bzerkpkbql6ite@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 08:21:10PM +0800, Dong Aisheng wrote:
> Hi Oleksij,
> 
> On Fri, Jun 1, 2018 at 2:58 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > The Mailbox controller is able to send messages (up to 4 32 bit words)
> > between the endpoints.
> 
> Could we really be able to send up to 4 42bit words with this driver?
> 
> It looks to me the current Mailbox framework is more designed for share mem
> transfer which does not fit i.MX MU well.

The mailbox framework just defines channels and messages. A message is a
void * which may contain arbitrary data or even no data at all; some
drivers simply ignore the message pointer, so in fact they act as a
doorbell unit only.

There's nothing about shared memory in the mailbox framework, but of
course you can combine a mailbox driver and shared memory to a remote
message mechanism. That could be done with the i.MX MU aswell and would
indeed be a good match for the hardware.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
