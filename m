From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Thu, 19 May 2016 18:53:09 +0200
Subject: [PATCH v3] mmc: dw_mmc: rockchip: Set the drive phase properly
In-Reply-To: <2865073.LogD6IIKLp@phil>
References: <1463077910-25914-1-git-send-email-dianders@chromium.org>
 <2865073.LogD6IIKLp@phil>
Message-ID: <CAFqH_52KqPXM_AjC8qKrVvH2hSvqtiBjmN28SZgJgoWVCe0pmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-05-13 0:52 GMT+02:00 Heiko Stuebner <heiko@sntech.de>:
> Am Donnerstag, 12. Mai 2016, 11:31:50 schrieb Douglas Anderson:
>
> [...]
>
>> In commit 7a03fe6f48f3 ("clk: rockchip: reset init state before mmc card
>> initialization") we actually started setting this explicitly in the
>> kernel, but that commit wasn't quite right and also wasn't quite
>> enough.  See <https://patchwork.kernel.org/patch/9085311/> for some
>> details.
>>
>> Let's explicitly set this phase in dw_mmc.
>
> [...]
>
>> Fixes: 7a03fe6f48f3 ("clk: rockchip: reset init state before mmc card
>> initialization") Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> I've tested this patch together with the two clock patches linked above on a
> rk3288-firefly and a rk3288-veyron-jerry. On the firefly tuning still does not
> work (probably really some regulator issue) and on veyron tuning still works
> as expected, so
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
> Doug's explanations both in the commit message and the code look sane to me,
> but I don't feel confident enough in my understanding of the matter to
> transform that into a Reviewed-by tag.
>
>

I've tested this patch on rock2 square inserting some uSD cards and
seeing that they still enumerate properly, also I booted from a uSD
card.
Note that in current state UHS is not supported so the tuning is not
executed. Enable UHS on rock2 requires some work, I'll try to look at
it but meanwhile I can say that doesn't break current state, so

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
