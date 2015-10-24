From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Sat, 24 Oct 2015 11:18:05 +0800
Subject: [PATCH v1 3/4] ASoC: Add codec machine driver for RK3036
In-Reply-To: <20151019191312.GQ32054@sirena.org.uk>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
 <1444698070-4191-4-git-send-email-zhengsq@rock-chips.com>
 <20151019191312.GQ32054@sirena.org.uk>
Message-ID: <562AF86D.8050303@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark & Sjoerd,

On 2015?10?20? 03:13, Mark Brown wrote:
> On Tue, Oct 13, 2015 at 09:01:08AM +0800, Shunqian Zheng wrote:
>> From: ZhengShunQian <zhengsq@rock-chips.com>
>>
>> This patch add the machine driver for rk3036.
> Like Sjoerd said this looks like it migh be better just using
> simple-card, if not...
Yes, simple-card works fine, I think I need to learn more and resend 
patches.

Thank you very much,
Shunqian
>
>> +	ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* set cpu DAI configuration */
>> +	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
> Set this in the dai_link struct.
