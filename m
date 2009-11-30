From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 30 Nov 2009 13:25:12 +0100
Subject: [PATCH 8/9 v2] MXC: Add a digital audio multiplexer driver
In-Reply-To: <20091130121017.GN27548@pengutronix.de>
References: <1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
	<20091112150615.GA30179@pengutronix.de>
	<eedb5540911300356p2b41eeaakee050953ad39ec26@mail.gmail.com>
	<20091130121017.GN27548@pengutronix.de>
Message-ID: <eedb5540911300425n374af9f0k5346d85fdb79eb11@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > You cannot calculate AUDMUX register offsets this way because according
> to
> > i.MX27 manual:
> >
> > 0x1001_6000 (HPCR1)
> > 0x1001_6004 (HPCR2)
> > 0x1001_6008 (HPCR3)
> > 0x1001_6010 (PPCR1)  <-- You are using 0x0C for this
> > 0x1001_6014 (PPCR2)  <--- You are using 0x10 for this
> > 0x1001_601C (PPCR3)  <--- You are using 0x18 for this
>
> It's fine the way it is. See mach/audmux.h:
>
> #define MX27_AUDMUX_HPCR1_SSI0          0
> #define MX27_AUDMUX_HPCR2_SSI1          1
> #define MX27_AUDMUX_HPCR3_SSI_PINS_4    2
> #define MX27_AUDMUX_PPCR1_SSI_PINS_1    3
> #define MX27_AUDMUX_PPCR2_SSI_PINS_2    4
> #define MX27_AUDMUX_PPCR3_SSI_PINS_3    5
>


Sorry for my insistence but, unless I am missing something weird, I have
looked at mach/audmux.h and still think that it is wrong:

AUDMUX PORT        Your offset         i.MX27 Manual offset
---------------------------        ------------------
---------------------------------------
(0) HPCR1                       (0 x 4) = 0x0        0x00
(1) HPCR2                       (1 x 4) = 0x4        0x04
(2) HPCR3                       (2 x 4) = 0x8        0x08
(3) PPCR1                       (3 x 4) = 0xC        0x10
(4) HPCR2                      (4 x 4) = 0x10        0x14
(5) HPCR3                      (5 x 4) = 0x14        0x1C


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091130/92016fac/attachment-0001.htm>
