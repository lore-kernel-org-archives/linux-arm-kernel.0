From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 02 Oct 2012 10:48:53 +0300
Subject: [alsa-devel] [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
In-Reply-To: <20120922153313.GN4495@opensource.wolfsonmicro.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com>
Message-ID: <506A9C65.5040309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2012 06:33 PM, Mark Brown wrote:
> On Fri, Aug 31, 2012 at 06:20:58PM +0530, Hebbar, Gururaja wrote:
> 
>> +config SND_DAVINCI_HAVE_SRAM
>> +	bool
>> +	default y if ARCH_DAVINCI=y
>> +	default n if ARCH_OMAP=y
>> +
> 
> I've been sitting on this mostly since it seems like a step back from
> multi-platform kernels (which is where we're trying to get to) and I've
> been trying to decide what the best approach is.  I'm thinking that we
> do want a generic API for allocating this stuff, it's a fairly generic
> feature (there's TCMs as well).  
> 
> Adding ifdefs like this does just doesn't seem good.

I also agree that ifdef is not a good solution.
It is better to have this information passed as device_data and via DT it can
be decided based on the compatible property for the device.

-- 
P?ter
