From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Mar 2013 22:18:15 +0100
Subject: [RFC PATCH 1/6] ARM, TCM: initialize TCM in paging_init(),
 instead of setup_arch()
In-Reply-To: <1364184674-13798-2-git-send-email-iamjoonsoo.kim@lge.com>
References: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1364184674-13798-2-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <CACRpkdYifJ+Lk4EETvmOwYk6R-cKcw=6TzZdLcHpGe3MxjY+OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 5:11 AM, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:

> tcm_init() call iotable_init() and it use early_alloc variants which
> do memblock allocation. Directly using memblock allocation after
> initializing bootmem should not permitted, because bootmem can't know
> where are additinally reserved.
> So move tcm_init() to a safe place before initalizing bootmem.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>
(On the U300)

You should put this into Russell's patch tracker for his judgement.

Yours,
Linus Walleij
