From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Sep 2015 21:36:44 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <560165EC.4050208@redhat.com>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442566130-3497-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64E-gQu1U_qi2fTWiCmfgMdMR4X6yLUerV21d3E1uQ1cw@mail.gmail.com>
 <20150922124708.GZ4684@lukather>
 <CAGb2v662+mhFgv1DXz5muA+xGE99R1DVKOxtVPvJmc+tRFPXzQ@mail.gmail.com>
 <56015146.2070509@redhat.com> <20150922140424.GA4684@lukather>
 <560165EC.4050208@redhat.com>
Message-ID: <20150929193644.GS7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 04:30:04PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 22-09-15 16:04, Maxime Ripard wrote:
> >On Tue, Sep 22, 2015 at 03:01:58PM +0200, Hans de Goede wrote:
> >>>In short, this is not about "power supply" but VBUS detection. IIRC,
> >>>if no VBUS detection method is provided, the phy driver just waits a
> >>>period of time after an ID pin change and then considers VBUS invalid.
> >>
> >>Right, but that is a hack for boards with no / broken vbus detection
> >>(or vbus control), we really want to use vbus-det where available,
> >>so I agree that a TODO comment here would be good.
> >
> >What's so special in our SoCs that makes that we can't just rely on
> >the ID pin ? (which seems to be working just fine here)
> 
> There is nothing special, AFAIK all OTG ports (also for other SoCs)
> have some sort of vbus detection mechanism. We need the hack because
> vbus-det is broken on some of our boards.
> 
> And where it is not broken we should be using vbus-det normallu.

Ah, and most controllers embed that directly into the controller
itself and don't rely on a GPIO to do that. Understood.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150929/f3a3e957/attachment-0001.sig>
