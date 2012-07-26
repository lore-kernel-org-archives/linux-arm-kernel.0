From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 16:23:33 +0100
Subject: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
In-Reply-To: <20120726151217.GO3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
 <20120726113204.GY3099@opensource.wolfsonmicro.com>
 <50112C29.6020606@linaro.org>
 <20120726114215.GB3099@opensource.wolfsonmicro.com>
 <50115961.6060509@linaro.org>
 <20120726151217.GO3099@opensource.wolfsonmicro.com>
Message-ID: <501160F5.5050807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/12 16:12, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 03:51:13PM +0100, Lee Jones wrote:
>
>> I don't think we want to use regmap at all, but we're forced to by
>> soc-core. How do we over-ride that behavior? By writing some
>> nonsense into codec->control_data?
>
> You should use that for your control data, yes - you're not forced to
> use regmap at all.  Like I say we've got a bunch of drivers doing so
> already.

What's my 'control data'? It's not used in the original codec patch.

The old way wants to go:

snd_soc_update_bits() -> snd_soc_read() -> ab8500_codec_read_reg()

When then calls back into the abx500.

So what 'control data' should I be storing in the codec struct?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
