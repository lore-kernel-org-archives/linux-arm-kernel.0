From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Dec 2016 10:36:19 +0100
Subject: [PATCH v2 2/3] ARM: dts: sunxi: add support for Orange Pi Zero
 board
In-Reply-To: <cdfd3c65-d473-badb-ea6a-035f7ab79217@arm.com>
References: <20161121162421.800-1-icenowy@aosc.xyz>
 <20161121162421.800-2-icenowy@aosc.xyz>
 <5373671480239408@web31m.yandex.ru>
 <cdfd3c65-d473-badb-ea6a-035f7ab79217@arm.com>
Message-ID: <20161201093619.gs6lmoxtlptp2jr6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 12:29:07AM +0000, Andr? Przywara wrote:
> > Something more interesting happened.
> > 
> > Xunlong made a add-on board for Orange Pi Zero, which exposes the
> > two USB Controllers exported at expansion bus as USB Type-A
> > connectors.
> > 
> > Also it exposes a analog A/V jack and a microphone.
> > 
> > Should I enable {e,o}hci{2.3} in the device tree?
> 
> Actually we should do this regardless of this extension board. The USB
> pins are not multiplexed and are exposed on user accessible pins (just
> not soldered, but that's a detail), so I think they qualify for DT
> enablement. And even if a user can't use them, it doesn't hurt to have
> them (since they are not multiplexed).

My main concern about this is that we'll leave regulators enabled by
default, for a minority of users. And that minority will prevent to do
a proper power management when the times come since we'll have to keep
that behaviour forever.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161201/6200cc6b/attachment.sig>
