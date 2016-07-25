From: dianders@chromium.org (Doug Anderson)
Date: Mon, 25 Jul 2016 07:19:03 -0700
Subject: [PATCH 2/3] phy: rockchip-emmc: Be tolerant to card clock of 0 in
 power on
In-Reply-To: <5795AA41.7070604@ti.com>
References: <1467049167-14628-1-git-send-email-dianders@chromium.org>
 <1467049167-14628-3-git-send-email-dianders@chromium.org>
 <5773D1FD.8020601@ti.com>
 <CAD=FV=U_-8HJRjWa8ktT=7tmM5RB4OVnDce-Bv2teDibYfbCeA@mail.gmail.com>
 <CAPDyKFqPHB2O=-hDxVda-h04WS9xYpJ3MyzH8bk5Fc4ogTfB5A@mail.gmail.com>
 <5795AA41.7070604@ti.com>
Message-ID: <CAD=FV=X1uZCH2273fR3VcYiD4_K2w2CPRgyejomQ-KoYrkHLjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 24, 2016 at 10:57 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Did you agree on how to move forward with this change?
>
> I think still few things are not very clear especially on what should be
> handled in PHY when the clock rate changes or if any new PHY APIs are required
> to handle any clock changes etc..
> But since this actually gets MMC working in rockchip, I'd be okay to merge this
> now. Though I'd expect this to be refined in the future release cycles.
>
> FWIW:
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thank you.  Agreed that I don't particularly like the revert and last
I checked with Shawn at Rockchip he was trying to find a better
solution.  ...but I also agree that landing the revert is better than
not landing it while we wait for a better solution.

IMHO in this particular case PHY API changes shouldn't be needed since
we should be able to use the CCF notifications.  ...but we need to
figure out how to do that in the case of the current card clock since
it's not really a fully fledged clock and doesn't support
notifications.  We might need to get advice from CCF guys...


-Doug
