From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 20 May 2015 12:17:57 +0200
Subject: [RFC PATCH 2/4] ARM: dts: Add SPI flash node for Peach boards
In-Reply-To: <555C0179.8040102@samsung.com>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-3-git-send-email-javier.martinez@collabora.co.uk>
 <555C0179.8040102@samsung.com>
Message-ID: <555C5F55.9010507@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/20/2015 05:37 AM, Krzysztof Kozlowski wrote:
> On 19.05.2015 22:34, Javier Martinez Canillas wrote:
>> From: Simon Glass <sjg@chromium.org>
>> 
>> Peach Pit and Pi machines have a SPI flash memory that is used to
>> store firmware and different system parameters and data.
>> 
>> Add information about the SPI flash chip so that user-space tools
>> can access it.
>> 
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> I assume this can go through samsung-soc tree (after documenting new
> compatible)?
>

Yes, I mentioned in the cover letter that patch #1 should go through
the spi tree and #2-4 through the linux-samsung tree. I can split in
two series once I post as proper patches to make it more clear.
 
> The exynos5800-peach-pi.dts and exynos5420-peach-pit.dts have a lot of
> common nodes. I wonder if there is a common part which could have its
> own dtsi? Like exynos4412-odroid-common.dtsi?
>

We discussed in the past about having a common .dtsi [0]. I'm not a
huge fan of a common .dtsi and I prefer to instead split common dts
fragments in a .dtsi that can be included in different dts.

That also better reflects what happens at the hw level IMHO since a
board may reuse a IP block. Doug Anderson seems to agree with me [1].
 
> Best regards,
> Krzysztof
>

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/6/26/271
[1]: https://lkml.org/lkml/2014/6/26/555
