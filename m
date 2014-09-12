From: xjq@rock-chips.com (Jianqun)
Date: Fri, 12 Sep 2014 18:12:10 +0800
Subject: [PATCH 1/2] ASoC: rockchip-max98090: add documentation for
 rockchip-max98090 driver
In-Reply-To: <3774516.jOvxH1lgyQ@diego>
References: <1410507036-15442-1-git-send-email-jay.xu@rock-chips.com>
 <1410513055-17775-1-git-send-email-jay.xu@rock-chips.com>
 <3774516.jOvxH1lgyQ@diego>
Message-ID: <5412C6FA.9020308@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 09/12/2014 06:04 PM, Heiko St?bner ??:
> Hi Jianqun,
> 
> Am Freitag, 12. September 2014, 17:10:55 schrieb Jianqun:
>> Add documentation for rockchip-max98090 driver, which is need by rockchip
>> board using a max98090.
>>
>> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
>> ---
>> changes since v1:
> 
> please make sure to also include the version in the patch subject, so that
> people can always see which is which. This one should've been
> 
> [PATCH v2 1/2] ASoC: rockchip-max98090: add documentation for rockchip-max98090 driver
> 
> Because without this identification, people can only try to guess which one is the
> newest version.
> 
ok, thanks, I will notice this in the future
> 
> Heiko
> 
>> - modify error text from "Tegra" to "rockchip"
>>
>>  .../sound/rockchip,rockchip-audio-max98090.txt     | 23
>> ++++++++++++++++++++++ 1 file changed, 23 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-max98090.tx
>> t
>>
>> diff --git
>> a/Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-max98090.
>> txt
>> b/Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-max98090.
>> txt new file mode 100644
>> index 0000000..e12d1a0
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-max98090.
>> txt @@ -0,0 +1,23 @@
>> +ROCKCHIP audio complex, with MAX98090 CODEC
>> +
>> +Required properties:
>> +- compatible : must be "rockchip,rockchip-audio-max98090"
>> +- rockchip,model : the user-visible name of this sound complex
>> +- rockchip,i2s-controller : The phandle of the rockchip I2S controller
>> +  that's connected to the CODEC.
>> +- rockchip,audio-codec : The phandle of the MAX98090 audio codec.
>> +
>> +Optional properties:
>> +- rockchip,hp-det-gpios : The GPIO that detect headphones are plugged in
>> +- rockchip,mic-det-gpios : The GPIO that detect micphones are plugged in
>> +
>> +Example:
>> +
>> +sound {
>> +	compatible = "rockchip,rockchip-audio-max98090";
>> +	rockchip,model = "ROCKCHIP-I2S";
>> +	rockchip,i2s-controller = <&i2s>;
>> +	rockchip,audio-codec = <&max98090>;
>> +	rockchip,hp-det-gpios = <&gpio6 5 GPIO_ACTIVE_HIGH>;
>> +	rockchip,mic-det-gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>;
>> +};
> 
> 
> 
> 
