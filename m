From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 20 Nov 2014 14:04:01 -0800
Subject: [PATCH resend 2/4] ARM: dts: sunxi: unify APB1 clock
In-Reply-To: <1415245232-20585-3-git-send-email-wens@csie.org> (Chen-Yu Tsai's
 message of "Thu, 6 Nov 2014 11:40:30 +0800")
References: <1415245232-20585-1-git-send-email-wens@csie.org>
 <1415245232-20585-3-git-send-email-wens@csie.org>
Message-ID: <7h1toxr0ku.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen-Yu Tsai <wens@csie.org> writes:

> From: Emilio L?pez <emilio@elopez.com.ar>
>
> With the new factors infrastructure in place, we can unify apb1 and
> apb1_mux as a single clock now.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> [wens at csie.org: Change apb1 node label to "apb1"; reword commit title]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Boot breakage in arm-soc/for-next on sun4i-a10-cubieboard and
sun7i-a20-cubieboard2[1] was bisected down to this patch[1].

Reverting $SUBJECT on top of arm-soc gets things booting again.

Kevin

[1] http://status.armcloud.us/boot/?cubie
[2]
e883d67285e9267c73f8d2b9d32aa9e712ad00a4 is the first bad commit
commit e883d67285e9267c73f8d2b9d32aa9e712ad00a4
Author: Emilio L?pez <emilio@elopez.com.ar>
Date:   Thu Nov 6 11:40:30 2014 +0800

    ARM: dts: sunxi: unify APB1 clock

    With the new factors infrastructure in place, we can unify apb1 and
    apb1_mux as a single clock now.

    Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
    [wens at csie.org: Change apb1 node label to "apb1"; reword commit
    title]
    Signed-off-by: Chen-Yu Tsai <wens@csie.org>
    Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

:040000 040000 ab2fd24827d8610215cfd517106f38f359e39f86 1d836ee4f4a2ff442d7d38829f87b72c32152bcc M      arch
bisect run success
