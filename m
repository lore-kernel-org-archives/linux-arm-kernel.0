From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Apr 2012 10:35:34 +0200
Subject: [PATCH] pinctrl: implement pinctrl deferred probing
In-Reply-To: <4F84537A.2020300@wwwdotorg.org>
References: <1334045048-15566-1-git-send-email-linus.walleij@stericsson.com>
 <4F84537A.2020300@wwwdotorg.org>
Message-ID: <CACRpkdYc3fbwX6oPKm8JAZLG-51vDXhihGqk=HAoS9Xz+BnF=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 5:36 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>> @@ -521,8 +521,11 @@ static int add_setting(struct pinctrl *p, struct pinctrl_map const *map)
>> ? ? ? ? ? ? ? dev_err(p->dev, "unknown pinctrl device %s in map entry",
>> ? ? ? ? ? ? ? ? ? ? ? map->ctrl_dev_name);
>
> Perhaps this dev_err (and the one in the other hunk) should be
> downgraded to warn/info/debug?

I've downgraded to dev_info() for now (see v2), I suspect people may have some
problems with deferred probing ATM so better log something for them. Later we
may set it to dev_dbg() if it looks too noisy...

Thanks,
Linus Walleij
