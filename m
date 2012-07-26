From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 15:51:13 +0100
Subject: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
In-Reply-To: <20120726114215.GB3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
 <20120726113204.GY3099@opensource.wolfsonmicro.com>
 <50112C29.6020606@linaro.org>
 <20120726114215.GB3099@opensource.wolfsonmicro.com>
Message-ID: <50115961.6060509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/12 12:42, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 12:38:17PM +0100, Lee Jones wrote:
>> On 26/07/12 12:32, Mark Brown wrote:
>
>>> Again, this makes no sense.  If we're explicitly being asked to use
>>> regmap then we should be using regmap or just failing to set up I/O
>>> (which is obviously a catastrophic failure).
>
>> How much work is there involved in regmap:ing a device, so that
>> dev_get_regmap() doesn't fail?
>
> Trivial if it's on a supported bus, otherwise you just need to write the
> bus.  But why do you care if dev_get_regmap() fails?  We only try to use
> regmap if the driver asked for regmap I/O (or doesn't have registers at
> all in which case it doesn't matter since we never do any I/O).  What
> you appear to be saying here is that you're using regmap on a device
> which doesn't have a regmap set up which is clearly never going to work
> terribly well...

I don't think we want to use regmap at all, but we're forced to by 
soc-core. How do we over-ride that behavior? By writing some nonsense 
into codec->control_data?


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
