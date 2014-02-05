From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 5 Feb 2014 12:43:18 +0800
Subject: [PATCH v3 8/8] ARM: dts: sun7i: Add ethernet alias for GMAC
In-Reply-To: <20140203193802.GE25625@lukather>
References: <1391398346-5094-1-git-send-email-wens@csie.org>
 <1391398346-5094-9-git-send-email-wens@csie.org>
 <20140203193802.GE25625@lukather>
Message-ID: <CAGb2v659T_QTLChB0NRS0seQvwDBCmTAH6UBEghZng9Ac6uL4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 3:38 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Feb 03, 2014 at 11:32:26AM +0800, Chen-Yu Tsai wrote:
>> U-Boot will insert MAC address into the device tree image.
>> It looks up ethernet[0-5] aliases to find the ethernet nodes.
>> Alias GMAC as ethernet0, as it is the only ethernet controller used.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
>> index 65fb8d0..c48fb11 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -17,7 +17,7 @@
>>       interrupt-parent = <&gic>;
>>
>>       aliases {
>> -             ethernet0 = &emac;
>> +             ethernet0 = &gmac;
>>       };
>
> I'm not very fond of this patch.
>
> People might rely on the fact that ethernet0 is actually the emac, and
> are expecting u-boot to fill the ethaddr variable to the emac, and not
> the gmac.
>
> Since u-boot is totally able to deal with several ethernet addresses,
> please add it as ethernet1.

Actually I think we should override this in the board dts.
The boards we currently support can only use emac or gmac,
and in our u-boot tree, they have been converted to using
gmac. If any future boards support both emac and gmac, we
can address the ordering then. And the ordering should
match u-boot.

What do you think?


Cheers
ChenYu
