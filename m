From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 30 Aug 2016 20:49:28 +0200
Subject: [PATCH v3 0/5] meson: Meson8b and GXBB DWMAC glue driver
In-Reply-To: <20160828.234008.445367966910278179.davem@davemloft.net>
References: <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
 <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
 <20160828.234008.445367966910278179.davem@davemloft.net>
Message-ID: <CAFBinCCmg-+8mjd0Xc5c7bEWL9_S_4kizs_UMiiW9ATBH_G8iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 5:40 AM, David Miller <davem@davemloft.net> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Date: Sun, 28 Aug 2016 18:16:32 +0200
>
>> This adds a DWMAC glue driver for the PRG_ETHERNET registers found in
>> Meson8b and GXBB SoCs. Based on the "old" meson6b-dwmac glue driver
>> the register layout is completely different.
>> Thus I introduced a separate driver.
>>
>> Changes since v2:
>> - fixed unloading the glue driver when built as module. This pulls in a
>>   patch from Joachim Eastwood (thanks) to get our private data structure
>>   (bsp_priv).
>
> This doesn't apply cleanly at all to the net-next tree, so I have
> no idea where you expect these changes to be applied.
OK, maybe Kevin can me help out here as I think the patches should go
to various trees.

I think patches 1, 3 and 4 should go through the net-next tree (as
these touch drivers/net/ethernet/stmicro/stmmac/ and the corresponding
documentation).
Patch 2 should probably go through clk-meson-gxbb / clk-next (just
like the other clk changes we had).
The last patch (patch 5) should probably go through the ARM SoC tree
(just like the other dts changes we had).

@David, Kevin: would this be fine for you?
