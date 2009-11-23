From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 23 Nov 2009 21:28:19 +0100
Subject: [PATCH] MX27: Add USB platform devices and resources
In-Reply-To: <37367b3a0911231028t48173bd1l56b48182c3c31edb@mail.gmail.com>
References: <eedb5540907150626m3dbf815bif92ff179b6ebfe58@mail.gmail.com>
	<20090716081235.GQ2714@pengutronix.de>
	<37367b3a0911230436i5d44cd80y182316ef056d6b31@mail.gmail.com>
	<37367b3a0911230718s3dd16d99n1b2ce858b79218ca@mail.gmail.com>
	<20091123153111.GM14091@buzzloop.caiaq.de>
	<37367b3a0911230825y55c443d3ga4e70c583a179ff6@mail.gmail.com>
	<20091123175847.GO14091@buzzloop.caiaq.de>
	<37367b3a0911231028t48173bd1l56b48182c3c31edb@mail.gmail.com>
Message-ID: <20091123202819.GP14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2009 at 04:28:13PM -0200, Alan Carvalho de Assis wrote:
> On 11/23/09, Daniel Mack <daniel@caiaq.de> wrote:
> >>
> >> I will try to modify it myself. Case you remember someone who already
> >> do that, please let me know.
> >
> > Should be easy to add. All you need to do is modify the parts which are
> > SoC specific, ie, not part of the EHCI spec. See mxc_set_usbcontrol()
> > and check if PORTSC needs some modifications (which I don't believe).
> >
> 
> In fact PORTSC1 is at same offset (0x184), then it should work to
> i.MX27 as well.

Check this register thoroughly - I'd bet there is some difference. Just
add an cpu_is_mx27() block there and fill in the specific definitions.

Daniel
