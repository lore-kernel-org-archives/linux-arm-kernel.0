From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Apr 2018 16:51:25 +0800
Subject: [PATCH v5 10/13] ARM: sun9i: smp: Move structures
In-Reply-To: <20180403084745.zuq6o3tlxpvcynev@flea>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-11-mylene.josserand@bootlin.com>
 <20180403084745.zuq6o3tlxpvcynev@flea>
Message-ID: <CAGb2v66QTGkMC21SS-zAbToVcmOp3oO4YMbvC5SyWwA2kP8uGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2018 at 4:47 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Tue, Apr 03, 2018 at 08:18:33AM +0200, Myl?ne Josserand wrote:
>> To prepare the support for sun8i-a83t, move some structures
>> at the beginning of the file.
>>
>> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
>
> I'm not quite sure what would be the benefit from that, if it's was
> working before, then it would probably work in your case as welle, right?

You should only need to move struct sunxi_mc_smp_data, since you are reading
the is_sun9i field. I suppose you could also get away with adding a global
variable just for that, and not have to store an index or pointer. Then none
of this code movement would be necessary. It would be slightly harder to
understand, but it's still contained within this file, and it has a clear
purpose, so I would call that acceptable.

ChenYu
