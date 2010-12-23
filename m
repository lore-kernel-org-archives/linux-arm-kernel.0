From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 23 Dec 2010 14:41:26 +0100
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <20101223100642.GD3636@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 23 Dec 2010 10:06:42 +0000")
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
Message-ID: <87k4j0ehdl.fsf@erwin.mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> Has anyone addressed my issue with it that this is wide-open for
> abuse by allocating large chunks of memory, and then remapping
> them in some way with different attributes, thereby violating the
> ARM architecture specification?
>
> In other words, do we _actually_ have a use for this which doesn't
> involve doing something like allocating 32MB of memory from it,
> remapping it so that it's DMA coherent, and then performing DMA
> on the resulting buffer?

Huge pages.

Also, don't treat it as coherent memory and just flush/clear/invalidate
cache before and after each DMA transaction.  I never understood what's
wrong with that approach.

-- 
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86-tlen.pl>--<jid:mina86-jabber.org>--ooO--(_)--Ooo--
