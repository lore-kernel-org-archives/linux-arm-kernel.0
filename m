From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 15 Dec 2010 16:10:16 +0100
Subject: [PATCH] i.MX51: Full iomux support
In-Reply-To: <87y67rcdnf.fsf@lechat.rtp-net.org>
References: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
	<87y67rcdnf.fsf@lechat.rtp-net.org>
Message-ID: <19720.55896.197553.407321@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Arnaud Patard (Rtp) writes:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
[...]
> > The following series picks up the patch from Lothar Wa?mann replacing
> > the struct pad_desc with a 64bit variable and adds full i.MX51 iomux
> > support based on this patch.
> > The iomux configurations are taken from the Freescale pinmux tool, so the
> > definitions should be rather complete. Anyway, there are some modes
> > not present in the tool.
> > I took the padmux settings from the old iomux support where present.
> 
> I'm seeing a lot of changes in the iomux file and I have a patch [1]
> setting the SION bit for all gpios configuration so that reading the PSR
> value is giving usefull results when the gpio is configured as output. I
> wanted to send it this week but it will obviously conflict with
> this. Should I test your patchset first and if it's working, wait
> for its merge or should I send it anyway ? How do you want to deal with
> this (as long as you're fine with setting the SION bit for all gpios) ?
> 
I had done the same, but had some trouble with this.
E.g. on our board GPIO1_7 is used as a generic GPIO to enable an
external clock oscillator for the USBH1 ULPI PHY. When the SION bit
for this pad was set, I got strange errors on the USBH1 port
(disconnecting low speed devices behind a hub would stall the
bus). When I removed the SION bit for that pin everything worked
well.

It looks like the SION setting may adversly affect the GPIO functions
on the i.MX51.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
