From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 Jul 2014 08:45:29 -0700
Subject: [PATCH 3/4] usb: dwc2: add compatible data for rockchip soc
In-Reply-To: <53D8934E.9040807@rock-chips.com>
References: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
 <1406684102-18313-1-git-send-email-kever.yang@rock-chips.com>
 <CAD=FV=Wqr0C7gj89DVof=gBo4mxvqqz0or7_vkdad==CkzzrPg@mail.gmail.com>
 <53D8934E.9040807@rock-chips.com>
Message-ID: <CAD=FV=UiY3gCFf17PXEMzVJmjYjDV=chA+tx=dA0uPJ46L6J=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Tue, Jul 29, 2014 at 11:40 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
>> Are you sure HNP/SRP is not available?  Do things break if you leave this
>> at 0?
>
> 1. HNP/SRP is not need right now, I didn't see it used in mobile devices.
> 2. If HNP/SRP is enabled, the controller will monitor the otg_vbus about 5V,
>     overcurrent change will happen if vbus not detect after switch to host
>     for a period of time.
>     If not, the controller will monitor b_valid signal about 3V instead of
> 5V vbus,
>     which match the hardware reference design from Rockchip.

OK.  USB is pretty far away from my realm of expertise and I knew even
less about OTG/gadget.  It does sound like there's no fundamental
issue with HNP/SRP on the SoC itself but that we're working around an
issue with the board, though.  If that's true, then perhaps we need
another device tree property?

-Doug
