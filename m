From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 6 Nov 2018 08:25:12 -0500 (EST)
Subject: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <6a59717f-8ae8-54f7-b948-b145171c82c3@arm.com>
References: <20181015221629.13924-1-stefan@agner.ch>
 <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
 <20181016084416.GF30658@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
 <fe7595f5d02424c9d92e437cd20361f9@agner.ch>
 <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr>
 <6a59717f-8ae8-54f7-b948-b145171c82c3@arm.com>
Message-ID: <nycvar.YSQ.7.76.1811060823150.1498@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Nov 2018, Robin Murphy wrote:

> On 06/11/2018 04:49, Nicolas Pitre wrote:
> [...]
> >> r3 and r5 are not used above, so no need to have them in the clobber
> >> list.
> > 
> > They are used. ldrd and strd instructions always use a pair of
> > consecutive registers. So "ldrd r2, ..." loads into r2-r3 and "ldrd r4, ..."
> > loads into r4-r5.
> 
> FWIW, since we should now be enabling unified syntax everywhere, I guess we
> could probably rewrite all those ldrd/strd to the UAL 3-operand form - i.e.
> "ldrd r2, r3, [...]" - if we really cared for the extra clarity.

Good idea. Worthy of a separate patch though.


Nicolas
