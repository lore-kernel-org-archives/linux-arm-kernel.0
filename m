From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Tue, 28 Nov 2017 16:48:26 +0100
Subject: [PATCH v2 2/4] DTS: GTA04: fix panel compatibility string
In-Reply-To: <20171128151039.GZ28152@atomide.com>
References: <cover.1510822218.git.hns@goldelico.com>
 <09d975dd62afa1dfa43d94079cc9a44731af4b3b.1510822218.git.hns@goldelico.com>
 <20171128145727.GY28152@atomide.com>
 <C108B0B6-FED7-44DB-9A18-39E3BE93E586@goldelico.com>
 <20171128151039.GZ28152@atomide.com>
Message-ID: <F14B3797-8154-4958-82AB-8E39C75BB97B@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

> Am 28.11.2017 um 16:10 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [171128 15:04]:
>> Hi Tony,
>> 
>>> Am 28.11.2017 um 15:57 schrieb Tony Lindgren <tony@atomide.com>:
>>> 
>>> * H. Nikolaus Schaller <hns@goldelico.com> [171116 08:53]:
>>>> Vendor string is "tpo" and not "toppoly".
>>>> 
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>> 
>>>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
>>>> index 4504908c23fe..ec27ed67a22a 100644
>>>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>>>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>>>> @@ -86,7 +86,7 @@
>>>> 
>>>> 		/* lcd panel */
>>>> 		lcd: td028ttec1 at 0 {
>>>> -			compatible = "toppoly,td028ttec1";
>>>> +			compatible = "tpo,td028ttec1";
>>>> 			reg = <0>;
>>>> 			spi-max-frequency = <100000>;
>>>> 			spi-cpol;
>>> 
>>> Applying into omap-for-v4.15/fixes thanks. The other dts patch seems
>>> like it can wait for v4.16 merge window.
>> 
>> Hm. Not really. It needs the panel driver to match. So either both or
>> none should be applied or it will break the panel from working.
>> 
>> I am just 1-2 hours away from submitting a -v3 (rebased and tested
>> on top of 4.15-rc1).
> 
> OK fine dropping both. Please update the description in both dts
> patches to make it clear they are needed as a fix. Preferrably
> with a proper fixes tag.

Well, it is not "needed" in a strong sense since current mainline&stable
works. It is more a style and consistency fix to use "tpo," everywhere.

> 
> Having "We can remove the "omapdss," prefix" in the description sure
> does not sounds like it's needed as a fix :)

The description has been improved on -v3.

> 
> Sounds like maybe these two should be just a single patch for
> a proper fix?

Hm. I usually get the feedback to separate DT and driver fixes into
separate commits... Therefore I submit patch sets in the hope they
are not picked apart :)

As promised -v3 is following now.

BR,
Nikolaus
