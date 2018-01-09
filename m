From: andreas@kemnade.info (Andreas Kemnade)
Date: Tue, 9 Jan 2018 18:43:47 +0100
Subject: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
In-Reply-To: <20171222124427.GI3374@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
Message-ID: <20180109184347.28ba0a6e@aktux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Dec 2017 13:44:27 +0100
Johan Hovold <johan@kernel.org> wrote:

[...]
> I'd suggest reiterating the problem you're trying to solve and
> enumerating the previously discussed potential solutions in order to
> find a proper abstraction level for this (before getting lost in
> implementation details).
> 
The main point here is in short words: Having a device powered on or off
when the uart it is attached to, is used or not used anymore,
so the already available userspace applications do not need to be changed.

I digged out a bit around:
alternative aproaches were:
adding hooks to the uart/tty layer:
https://marc.info/?l=linux-kernel&m=143333222014616&w=2
https://marc.info/?l=devicetree&m=143130955414580&w=2

I do not find it right now in my archive:
adding a virtual gpio for dtr to the omap_serial driver.
The driver behind the virtual io would then handle pm. One reason it was
rejected was that the devicetree should only contain real hardware and
not virtual stuff.

Regards,
Andreas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/d11fd581/attachment.sig>
