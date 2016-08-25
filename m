From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Aug 2016 22:47:26 +0200
Subject: [PATCH 2/2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <116041472134355@web12g.yandex.ru>
References: <20160823064451.25997-1-icenowy@aosc.xyz>
 <20160823064451.25997-3-icenowy@aosc.xyz>
 <20160824193600.GS8103@lukather> <43951472083107@web23m.yandex.ru>
 <CAGb2v66tFENk8QBw7D1+bwFN-zWaE2SGDrNyc-zdbJSRzENk4Q@mail.gmail.com>
 <97321472108244@web8m.yandex.ru> <20160825080334.GD7776@lukather>
 <116041472134355@web12g.yandex.ru>
Message-ID: <20160825204726.GH32598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 10:12:35PM +0800, Icenowy Zheng wrote:
> >> ?But many codes will require a ttyS0 as console... So I think the
> >> ?bluetooth should be located at ttyS1...
> >
> > Most of them would use /dev/console anyway. What do you have in mind?
> 
> As a general configuration, /dev/ttyS0 will be indicated as the default console=
> value... (Otherwise more boards will fail)

There's no reason to make that assumption. The console might be on
another UART entirely (ttyS3, for the sake of the argument), on a
different UART "class" (ttyUSB?, framebuffer console?), or not present
at all.

If you want to use the console, use /dev/console.

I don't what's so special about the UART here. Every single device in
Linux behaves that way.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/a14fdef5/attachment-0001.sig>
