From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 13 Feb 2016 23:52:42 +0100
Subject: [PATCH v2] pinctrl: mvebu: fix num_settings in mpp group
 assignment
In-Reply-To: <1454366903-7038-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1453844952-28292-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1454366903-7038-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdaPwbood17LBS-PGQsDSe24jZnT_u8ySuJWWkSiUQNMmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 11:48 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> When assigning mpp settings from static mpp modes to mpp groups,
> we do not want any groups that have no supported setting for a
> specific Kirkwood variant. However, when there is at least a
> single supported setting, we need to assign the number of all
> settings in this mode to grp->num_settings as we are reusing
> the static modes table.
>
> Fixes: 0581b16b1840 ("pinctrl: mvebu: complain about missing group after checking variant")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> --
> Changelog:
> v1->v2:
> - Chose a less intrusive fix by adding supp_settings variable
>   instead of looping over the settings twice.

Patch applied with Aaro's Test tag.

Yours,
Linus Walleij
