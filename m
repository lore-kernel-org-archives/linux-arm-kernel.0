From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 11 Mar 2014 08:39:11 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <CAL_JsqJ00Zr1tMoyR1+qHUhsNoc6Kj6s+nTZTkNTwki9HFHq8g@mail.gmail.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>	<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<1393604717.3802.61.camel@paszta.hi.pengutronix.de>
 <CAL_JsqJ00Zr1tMoyR1+qHUhsNoc6Kj6s+nTZTkNTwki9HFHq8g@mail.gmail.com>
Message-ID: <531EAF8F.2040400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/14 23:45, Rob Herring wrote:

> I like this proposal over the others. Although, would dual link be a

I don't like inferring the information. With the above, you can't find
out that the DVI connector has digital and analog support before all the
drivers are loaded.

> single endpoint or 2 endpoints? How would you differentiate that?

Hmm, well endpoints for a single port are exclusive. So it's either a
single port and a single endpoint, or two ports and two endpoints. I
think dual link has to be single port & endpoint, as the TMDS links need
to be driven together as a single bus.

And dual-link is not really "two links". DVI dual-link means 1 clock
lane and 6 data lanes, compared to 1 clock lane and 3 data lanes for
single-link.

> The port node seems a bit pointless.

There's another thread discussing the ports and endpoints.

The port node represents, for example, the pins for the connection for
that device. And an endpoint-endpoint link represents wires between two
ports.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/a7245985/attachment.sig>
