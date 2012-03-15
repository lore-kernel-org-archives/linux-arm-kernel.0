From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 15 Mar 2012 07:53:29 +0100
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <20120315030206.GB13022@shlinux2.ap.freescale.net>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314124512.GG1180@shlinux2.ap.freescale.net>
 <20120314141643.GP3852@pengutronix.de>
 <20120315030206.GB13022@shlinux2.ap.freescale.net>
Message-ID: <20321.37353.63115.664975@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng writes:
> On Wed, Mar 14, 2012 at 10:16:43PM +0800, s.hauer at pengutronix.de wrote:
> > On Wed, Mar 14, 2012 at 08:45:23PM +0800, Dong Aisheng wrote:
> > > On Wed, Mar 14, 2012 at 01:23:51AM +0800, Grant Likely wrote:
[...]
> > > But it seems this needs pass mac address to fec driver via platforom data which is
> > > not friendly to dt.
> > > 
> > > Another way may be changing fec driver to get the fixed part of mac address(first
> > > two bytes) from device tree and read the left dynamical part from otp which i'm not
> > > sure is better enough.
> > > 
> > > BTW, filling with zeros seems not work since it's invalid mac address.
> > 
> > Yes, that's the idea of using this value...
> > 
> But comparing to use an invalid value, why not just do not define that
> local-mac-address property?
> 
Because a MAC address is by definition a GLOBALLY UNIQUE IDENTIFIER
which is contrary to coding a "valid" default value for it somewhere!
The owner of a certain MAC address range (OUI) is responsible for
ensuring the uniqueness. Thus only they may assign a specific MAC
address to a specific device.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
