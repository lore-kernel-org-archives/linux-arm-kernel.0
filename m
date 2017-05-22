From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 May 2017 17:37:31 +0200
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
In-Reply-To: <20170512171417.GH3489@atomide.com>
References: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
 <CACRpkdasvjBPcr5RrPwtTYaoGeTEJMWqXbSRaB5-cOEKXbpfRg@mail.gmail.com>
 <f529e2d1-68e0-2760-3fd0-c7b0e94dd003@arm.com>
 <CACRpkdZhUnu09CcRwkLS9Qf83OLiKkTVCQxZY0tsJmBHNAirVw@mail.gmail.com>
 <20170512153522.GG3489@atomide.com> <20170512171417.GH3489@atomide.com>
Message-ID: <CACRpkdYXQFnAHORAKBzOGzpQ_92p+Uj1DE9z-L2vz-bFj38MJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 7:14 PM, Tony Lindgren <tony@atomide.com> wrote:

> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 12 May 2017 08:47:57 -0700
> Subject: [PATCH] pinctrl: core: Fix warning by removing bogus code
>
> Andre Przywara <andre.przywara@arm.com> noticed that we can get the
> following warning with -EPROBE_DEFER:
>
> "WARNING: CPU: 1 PID: 89 at drivers/base/dd.c:349
> driver_probe_device+0x2ac/0x2e8"
>
> Let's fix the issue by removing the indices as suggested by
> Tejun Heo <tj@kernel.org>. All we have to do here is kill the radix
> tree.
>
> I probably ended up with the indices after grepping for removal
> of all entries using radix_tree_for_each_slot() and the first
> match found was gmap_radix_tree_free(). Anyways, no need for
> indices here, and we can just do remove all the entries using
> radix_tree_for_each_slot() along how the item_kill_tree() test
> case does.
>
> Fixes: c7059c5ac70a ("pinctrl: core: Add generic pinctrl functions
> for managing groups")
> Fixes: a76edc89b100 ("pinctrl: core: Add generic pinctrl functions
> for managing groups")
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks! This nice inline patch applied for fixes with Andr?'s tags.

Yours,
Linus Walleij
