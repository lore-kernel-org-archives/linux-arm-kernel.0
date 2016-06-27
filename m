From: carlo@caione.org (Carlo Caione)
Date: Mon, 27 Jun 2016 10:43:26 +0200
Subject: [PATCH v2 2/2] ARM: dts: meson: fixed size of the meson-ir
 registers
In-Reply-To: <20160626210622.5257-3-martin.blumenstingl@googlemail.com>
References: <20160626210622.5257-1-martin.blumenstingl@googlemail.com>
 <20160626210622.5257-3-martin.blumenstingl@googlemail.com>
Message-ID: <20160627084326.GA1737@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/16 23:06, Martin Blumenstingl wrote:
> According to the reference driver (and the datasheet of the newer
> Meson8b/S805 and GXBB/S905 SoCs) there are 14 registers, each 32 bit
> wide.

Then why are you modifying the DTS for the Meson6? As Neil already
suggested, it seems that the hardware has been slightly modified for the
latest SoCs, so this approach is clearly wrong.
Add a new compatible and use of_device_get_match_data() to get the SoC
specific data.

> Adjust the register size to reflect that, as register offset 0x20 is
> now also needed by the meson-ir driver.

According to the AML8726-MX (meson6) datasheet the value of 0x20 is
correct, at least for that hardware.

Cheers,

-- 
Carlo Caione
