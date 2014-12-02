From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Dec 2014 09:47:18 -0800
Subject: [PATCH v2] mmc: dw_mmc: add quirk for broken data transfer over
 scheme
In-Reply-To: <547D6F36.50103@rock-chips.com>
References: <1415970338-2637-1-git-send-email-addy.ke@rock-chips.com>
 <1416903008-4160-1-git-send-email-addy.ke@rock-chips.com>
 <CAD=FV=UmG1okxJ5JV-1cuRRQJi7EEPXc7Q90sWjfMWBqb7VSMw@mail.gmail.com>
 <547D6F36.50103@rock-chips.com>
Message-ID: <CAD=FV=V3BF8qv17n4_T5Lys1BnKsqE9NqOTB-6OwX0VOviWRrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Mon, Dec 1, 2014 at 11:50 PM, addy ke <addy.ke@rock-chips.com> wrote:
> We don't know why we have this problem,
> but this problem is really exist, and we need patch to fix this problem now.
> I will post a follow up change when we find the root cause.

To me that seems reasonable.  Certainly I would prefer to have this
patch while waiting for the root cause, but it's up to Ulf.


> And there is a little probability of this problem on RK SoC, such as RK3188, RK3066,
> when worse card inserted in.
> Maybe the other SoCs have the similar problem.
>
> So I will add this quirk in rockchip code(dw_mmc-rockchip.c) as follows:
> static int dw_mci_rockchip_parse_dt(struct dw_mci *host)
> {
>         host->quirk |= DW_MCI_QUIRK_BROKEN_DTO;
>
>         return 0;
> }
>
> ......
>         .parse_dt = dw_mci_rockchip_parse_dt,
> ......
>
> is right?

When you added "sdio_id0" you got feedback that you should use
dw_mci_rockchip_init().  Why not do the same thing here?
