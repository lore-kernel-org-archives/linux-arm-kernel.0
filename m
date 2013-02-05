From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Feb 2013 16:47:05 +0000
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <CACRpkda8xBB35CwuBH76xXcC341TeRs1ZuwzDD0LtuXc4ifQTw@mail.gmail.com>
References: <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi>
 <510FF5C9.3030600@mvista.com>
 <20130204170216.GC4269@arwen.pp.htv.fi> <51100A72.6030909@ti.com>
 <CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
 <5110369B.9060901@ti.com>
 <CACRpkda8xBB35CwuBH76xXcC341TeRs1ZuwzDD0LtuXc4ifQTw@mail.gmail.com>
Message-ID: <20130205164705.GG4720@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 05:21:48PM +0100, Linus Walleij wrote:

> For IRQ mode, use the completion callback to push each cookie
> to NAPI, and thus let the IRQ drive the traffic.

The whole purpose of NAPI is to avoid taking interrupts for completion
of transfers.  Anything that generates interrupts when NAPI is in
polling mode is defeating the point.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/a8f72bcf/attachment.sig>
