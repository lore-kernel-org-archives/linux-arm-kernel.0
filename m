From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 13:54:58 +0200
Subject: [PATCH 1/2] pinctrl: armada-37xx: Fix the pin 23 on south bridge
In-Reply-To: <20170801155720.10229-2-gregory.clement@free-electrons.com>
References: <20170801155720.10229-1-gregory.clement@free-electrons.com>
 <20170801155720.10229-2-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYT7tdQmmx4G+sxcv8ydyc506N-XfYLe4C=3jh7dJBi3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 5:57 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> Pin 23 on South bridge does not belong to the rgmii group. It belongs to
> a separate group which can have 3 functions.
>
> Due to this the fix also have to update the way the functions are
> managed. Until now each groups used NB_FUNCS(which was 2) functions. For
> the mpp23, 3 functions are available but it is the only group which needs
> it, so on the loop involving NB_FUNCS an extra test was added to handle
> only the functions added.
>
> The bug was visible with the merge of the commit 07d065abf93d "arm64:
> dts: marvell: armada-3720-db: Add vqmmc regulator for SD slot", the gpio
> regulator used the gpio 23, due to this the whole rgmii group was setup
> to gpio which broke the Ethernet support on the Armada 3720 DB
> board. Thanks to this patch, the UHS SD cards (which need the vqmmc)
> _and_ the Ethernet work again.
>
> Cc: stable at vger.kernel.org
> Fixes: 87466ccd9401 ("pinctrl: armada-37xx: Add pin controller support
> for Armada 37xx")
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied for fixes.

Yours,
Linus Walleij
