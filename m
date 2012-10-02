From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Oct 2012 14:07:20 +0530
Subject: [PATCH 2/3] ASoC: Davinci: pcm: add support for sram-support-less
 platforms
In-Reply-To: <20120922153313.GN4495@opensource.wolfsonmicro.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com>
Message-ID: <506AA7C0.5080300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 9/22/2012 9:03 PM, Mark Brown wrote:
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

How about converting to use genalloc instead of the DaVinci private SRAM
API and passing the pool to be used via platform data?

Matt Porter just used this approach to make the uio PRUSS driver usable
on both DaVinci and AM335x. It suffered from the exact same problem.

https://patchwork.kernel.org/patch/1522481/

Thanks,
Sekhar
