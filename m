From: sugar.zhang@rock-chips.com (sugar)
Date: Mon, 9 Nov 2015 15:21:53 +0800
Subject: [PATCH v3 1/3] ASoC: rockchip: i2s: add 8 channels capture support
In-Reply-To: <20151106120020.GH18409@sirena.org.uk>
References: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
 <1446773891-32174-2-git-send-email-sugar.zhang@rock-chips.com>
 <20151106120020.GH18409@sirena.org.uk>
Message-ID: <56404991.6000505@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/6/2015 20:00, Mark Brown wrote:
> On Fri, Nov 06, 2015 at 09:38:09AM +0800, Sugar Zhang wrote:
>
>> +	/* refine capture channels */
>> +	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
>> +		if (val >= 2 && val <= 8)
>> +			rockchip_i2s_dai.capture.channels_max = val;
>> +		else
>> +			rockchip_i2s_dai.capture.channels_max = 2;
>> +	}
>
> You should make a copy of the rockchip_i2s_dai struct in your driver
> data and modify that rather than modifying the original - what happens
> if sommeone makes a SoC with two I2S DAIs, one with many channels and
> another with only two?  Samsung SoCs often have an arrangement like that
> for exmaple.
>

Yes, I agree, because this patch was merged into mainline, I will post a 
new one based on the latest code to fix this, thanks.
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
