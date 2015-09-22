From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Sep 2015 16:30:04 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <20150922140424.GA4684@lukather>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442566130-3497-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64E-gQu1U_qi2fTWiCmfgMdMR4X6yLUerV21d3E1uQ1cw@mail.gmail.com>
 <20150922124708.GZ4684@lukather>
 <CAGb2v662+mhFgv1DXz5muA+xGE99R1DVKOxtVPvJmc+tRFPXzQ@mail.gmail.com>
 <56015146.2070509@redhat.com> <20150922140424.GA4684@lukather>
Message-ID: <560165EC.4050208@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22-09-15 16:04, Maxime Ripard wrote:
> On Tue, Sep 22, 2015 at 03:01:58PM +0200, Hans de Goede wrote:
>>> In short, this is not about "power supply" but VBUS detection. IIRC,
>>> if no VBUS detection method is provided, the phy driver just waits a
>>> period of time after an ID pin change and then considers VBUS invalid.
>>
>> Right, but that is a hack for boards with no / broken vbus detection
>> (or vbus control), we really want to use vbus-det where available,
>> so I agree that a TODO comment here would be good.
>
> What's so special in our SoCs that makes that we can't just rely on
> the ID pin ? (which seems to be working just fine here)

There is nothing special, AFAIK all OTG ports (also for other SoCs)
have some sort of vbus detection mechanism. We need the hack because
vbus-det is broken on some of our boards.

And where it is not broken we should be using vbus-det normallu.

Regards,

Hans
