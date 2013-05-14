From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 13:09:05 +0200
Subject: [PATCH 8/9] pinctrl: abx500: Rejiggle platform data and DT
 initialisation
In-Reply-To: <20130514094036.GI3297@gmail.com>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdZTU1gv3onjFF4eqxv-o1BQwd48u4gQ9NWqryWoMiKTDQ@mail.gmail.com>
 <20130514084756.GE3297@gmail.com>
 <CACRpkdbhHnrN3MGufubyYLNXdcCgZ2OpQ4a2CG6bwPJk88DZRg@mail.gmail.com>
 <20130514094036.GI3297@gmail.com>
Message-ID: <CACRpkda5v5BOidCNEnGK5TFyvbBd0R85Enu5hdhBzdjbn45BNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 11:40 AM, Lee Jones <lee.jones@linaro.org> wrote:

>> I'm happy to apply it but what do I write in the commit message?
>
> Platform Data is invariably populated for this driver, even when
> booting with Device Tree. Thus the Device Tree probing code encased
> within the first check for Platform Data will never executed, causing
> the driver to fail when DT is enabled.
>
> This patch fixes the aforementioned regression by rejigging the
> probe() semantics to attempt to extract a platform ID from Device Tree
> if one can not be sourced from platform data.

Thanks!
Copy/pasted into commit message and applied to fixes.

Yours,
Linus Walleij
