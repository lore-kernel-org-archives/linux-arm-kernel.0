From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 10:40:10 +0200
Subject: [PATCH 8/9] pinctrl: abx500: Rejiggle platform data and DT
 initialisation
In-Reply-To: <1368019749-19455-9-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZTU1gv3onjFF4eqxv-o1BQwd48u4gQ9NWqryWoMiKTDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:

> A pointer to GPIO platform data is always passed to the driver now, so
> there's little point in checking for 'pdata' and executing the DT case if
> it's not there. The difference between booting with DT and !DT is when
> booting with DT, plat_id is not populated. Thus, in the DT case we have
> to use a DT match table in order to find out which platform we're
> executing on. So, we're changing the semantics here to only use the
> match table if no plat_id is supplied though platform data.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Is this really included in the [0/9] fire alarm wrapper statement
"Important ux500 fixups due for the v3.10 -rc:s"?

It seems more like a random refactoring to me.

The commit message fails to specify which regression this
is fixing, like if it's causing an oops or so.

So I've tentatively applied it to the pinctrl devel branch for
v3.11 unless something comes up...

Yours,
Linus Walleij
