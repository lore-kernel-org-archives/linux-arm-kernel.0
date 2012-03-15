From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 15 Mar 2012 18:59:28 +0800
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <20321.37353.63115.664975@ipc1.ka-ro>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314124512.GG1180@shlinux2.ap.freescale.net>
 <20120314141643.GP3852@pengutronix.de>
 <20120315030206.GB13022@shlinux2.ap.freescale.net>
 <20321.37353.63115.664975@ipc1.ka-ro>
Message-ID: <20120315105927.GE13022@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Wa?mann wrote:
> Hi,
> 
> Dong Aisheng writes:
> > On Wed, Mar 14, 2012 at 10:16:43PM +0800, s.hauer at pengutronix.de wrote:
> > > On Wed, Mar 14, 2012 at 08:45:23PM +0800, Dong Aisheng wrote:
> > > > On Wed, Mar 14, 2012 at 01:23:51AM +0800, Grant Likely wrote:
> [...]
> > > > But it seems this needs pass mac address to fec driver via platforom data which is
> > > > not friendly to dt.
> > > > 
> > > > Another way may be changing fec driver to get the fixed part of mac address(first
> > > > two bytes) from device tree and read the left dynamical part from otp which i'm not
> > > > sure is better enough.
> > > > 
> > > > BTW, filling with zeros seems not work since it's invalid mac address.
> > > 
> > > Yes, that's the idea of using this value...
> > > 
> > But comparing to use an invalid value, why not just do not define that
> > local-mac-address property?
> > 
> Because a MAC address is by definition a GLOBALLY UNIQUE IDENTIFIER
> which is contrary to coding a "valid" default value for it somewhere!
> The owner of a certain MAC address range (OUI) is responsible for
> ensuring the uniqueness. Thus only they may assign a specific MAC
> address to a specific device.
> 
Yes, you're correct.
So i propose to read the MAC address from MX28 OTP in fec driver instead of
define it in device tree in my last mail.
http://www.spinics.net/lists/arm-kernel/msg165040.html
Do you have any comment on that way?

Regards
Dong Aisheng
