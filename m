From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Dec 2014 19:05:27 -0800
Subject: [PATCH v6 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <CAD=FV=WcAJAgj2triu1W4863BT1ew2wf-z6YNHHwiDKpnYmK4w@mail.gmail.com>
References: <1418291722-25448-1-git-send-email-lyz@rock-chips.com>
 <1418291722-25448-2-git-send-email-lyz@rock-chips.com>
 <CAD=FV=WcAJAgj2triu1W4863BT1ew2wf-z6YNHHwiDKpnYmK4w@mail.gmail.com>
Message-ID: <CAD=FV=XrOpZ16k7dNyqzf8m_8Sjq8yn5xCj7+YLiTPU3O2KrrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yunzhi,

On Thu, Dec 11, 2014 at 10:09 AM, Doug Anderson <dianders@chromium.org> wrote:
>> +               rk_phy->phy = devm_phy_create(dev, NULL, &ops);
>
> This has the wrong number of arguments.  Even before the change that
> added the 4th argument, this is still wrong because "ops" is supposed
> to be the 2nd argument, not the 3rd.
>
> ...so I'm confused how this compiled for you.  I think this ought to be:
>
> rk_phy->phy = devm_phy_create(dev, child, &ops, NULL);
>
> ...but please correct me if I'm mistaken!

As you pointed out privately, I didn't have (dbc9863 phy: remove the
old lookup method).  Sorry about the noise..

Hopefully my other comments are not quite as stupid...

-Doug
