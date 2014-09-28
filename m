From: xjq@rock-chips.com (Jianqun)
Date: Sun, 28 Sep 2014 08:54:27 +0800
Subject: [PATCH 1/2] ASoC: rockchip-max98090: add documentation for
 rockchip-max98090 driver
In-Reply-To: <20140912134446.GT7960@sirena.org.uk>
References: <1410506806-15327-1-git-send-email-jay.xu@rock-chips.com>
 <1410507036-15442-1-git-send-email-jay.xu@rock-chips.com>
 <20140912134446.GT7960@sirena.org.uk>
Message-ID: <54275C43.8010205@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 09/12/2014 09:44 PM, Mark Brown ??:
> On Fri, Sep 12, 2014 at 03:30:36PM +0800, Jianqun wrote:
>> Add documentation for rockchip-max98090 driver, which is need by rockchip
>> board using a max98090.
> 
> Can this use simple-card (perhaps after a bit of extension)?
I haven't ever try simple-card, is there any sample usage for me from other vendor ?
> 
>> +- rockchip,audio-codec : The phandle of the MAX98090 audio codec.
> 
> Is the driver really specific to this CODEC?
I think yes, we need to add two gpio for mic and hp detect, but simple-card driver hasn't them
> 
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
>> -- 
>> 1.9.1
>>
>>
>>

-- 
Jianqun Xu

****************************************************************************
*IMPORTANT NOTICE:*This email is from Fuzhou Rockchip Electronics Co.,
Ltd .The contents of this email and any attachments may contain
information that is privileged, confidential and/or exempt from
disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure,
copying, distribution, or use of the information is STRICTLY PROHIBITED.
Please immediately contact the sender as soon as possible and destroy
the material in its entirety in any format. Thank you.
****************************************************************************
