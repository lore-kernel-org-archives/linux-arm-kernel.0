From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Mar 2012 16:24:13 +0000
Subject: [alsa-devel] [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
In-Reply-To: <CA+7tXiiJyLAm1ytyqQYgbJ_roUtXwxqhFWKEBk+4jY_HV5V8Zg@mail.gmail.com>
References: <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
 <4F61F080.4090800@freescale.com>
 <20120315142115.GB6065@S2101-09.ap.freescale.net>
 <CA+7tXig6=gz8utcnV8qUs6=JnwEz8+tqc-57v-xNcYcK_AAHXw@mail.gmail.com>
 <CA+7tXiiJyLAm1ytyqQYgbJ_roUtXwxqhFWKEBk+4jY_HV5V8Zg@mail.gmail.com>
Message-ID: <20120315162413.GO3138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 11:57:52AM -0400, Trent Piepho wrote:

> which caused text window in gmail to become deselected, which caused a
> subsequent enter to send the email rather than creating a new line.

> For esai, would you add something like:
>     esai-controller = <&esai1>;
>     esai-audio-codec = <&sgtl5000_3>;

> That seems rather ugly to me.

None of these examples seem particularly to reflect realistic audio
hardware; they're more describing a board with multiple distinct audio
subsystems on it than a single card.  Remember that nothing at all is
fixed about how the card binding works internally, the card driver is
free to pick any binding that makes sense for the systems it supports.
Shoehorning every possible card into the same binding is definitely a
really bad idea.

> It seems to me in most device bindings where one piece of hardware is
> attached to another, than the one upstream has in its binding a
> phandle to the one downstream.  But here we have a third binding with
> two lists of devices and an implied link between devices in
> corresponding positions in the lists.  Does any other device binding
> work like that?

There's no upstream and downstream here, really.  But like I say none of
this looks like realistic hardware anyway.

*Please* go and read the previous discussions of audio bindings for
SoCs, while it's more understandable with people who haven't been
involved before its still tiresome to have to go back to square one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/8ed7c6cc/attachment.sig>
