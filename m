From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 27 Nov 2014 15:36:16 +0000
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <2978273.VePW8UymqL@wuerfel> (Arnd Bergmann's message of "Thu, 27
 Nov 2014 16:00:01 +0100")
References: <5476FFA2.8010403@free.fr> <7958894.CNnhBWEkgT@wuerfel>
 <54773A8B.5000200@free.fr> <2978273.VePW8UymqL@wuerfel>
Message-ID: <yw1x61e0fyfj.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 27 November 2014 15:51:55 Mason wrote:
>> Arnd,
>> 
>> First of all, thanks (a lot) for your highly informative replies!
>> 
>> On 27/11/2014 14:12, Arnd Bergmann wrote:
>> 
>> > On Thursday 27 November 2014 14:01:41 Mason wrote:
>> >
>> >> #define gbus_read_reg32(r)      __raw_readl((volatile void __iomem *)IO_ADDRESS(r))
>> >> #define gbus_write_reg32(r, v)  __raw_writel(v, (volatile void __iomem *)IO_ADDRESS(r))
>> >
>> > Right, that's how things used to be done a while ago.
>> 
>> So, IIUC, old code used to call __raw_readl directly, but modern
>> code is supposed to call either readl or readl_relaxed?
>> 
>> (BTW, the original code is 4-5 years old, while my target is 3.14.x)
>
> I meant the IO_ADDRESS stuff. Modern code uses ioremap() instead
> since the IO_ADDRESS was platform specific, and drivers can no longer
> use platform headers on CONFIG_ARCH_MULTIPLATFORM, which is used
> for all new code now.
>
> The __raw_readl() was probably considered bad back then already, but
> a lot of people did it as we were lacking readl_relaxed().
>
> Would you consider submitting the code upstream?

This appears to be targeting a Sigma Designs chip, and nobody has to my
knowledge ever seen anything go upstream from them.

-- 
M?ns Rullg?rd
mans at mansr.com
