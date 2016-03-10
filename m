From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 10 Mar 2016 10:58:29 +0000
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <20160310094000.GA2057@tarshish>
References: <201603101013.04618.arnd@arndb.de> <20160310094000.GA2057@tarshish>
Message-ID: <56E15355.1040908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On 10/03/16 09:40, Baruch Siach wrote:
> Hi Arnd,
>
> On Thu, Mar 10, 2016 at 10:13:04AM +0100, Arnd Bergmann wrote:
>> I've found out that ARMv3 and ARMv4 is now on track to get removed from gcc in the future,
>> so I'm trying to alert everyone that I have knowledge of using ARMv4 based platforms that
>> we currenly support in the Linux kernel.
>>
>> The architecture has been declared obsolete here: https://gcc.gnu.org/gcc-6/changes.html
>> and it will be removed in the following release (gcc-7) one year later, unless someone
>> raises concerns over it.
>>
>> We will of course be able to compile kernels for a long time using older compilers, but
>> this tends to get harder over the years as people upgrade to newer distros.
>>
>> Here is an overview of which ARMv4 platforms we still have as of Linux-4.6:
>>
>> * Moxart: this is the only one that was recently (2013) added, and is apparently
>>    hardware that remains commercially available.
>>
>> * Gemini: officially supported in OpenWRT today, with the latest compiler. This one
>>    will likely cause the most issues for actual users. It would be helpful to get
>>    some numbers about users or downloads here, to see whether it can be dropped
>>    in a future OpenWRT release or if it might be possible to leave this on
>>    gcc-6.x when the other platforms move on to gcc-7+
>>
>> * sa1100: A lot of people have these, but I'm guessing this is mostly interesting
>>    for hobbyists that are able to keep using older gcc versions.
>>
>> * RiscPC, Footbridge, EBSA110: Classic systems that used to be popular in
>>    the past but only remain in small quantities as far as I know. Russell still
>>    uses them. He also uses older compilers, so probably isn't affected
>>    immediately.
>
> There are also quite a few ARM920T (ARMv4) based SoCs: EP93xx, Atmel
> AT91RM9200, Samsung S3C24xx, Freescale i.MX1.

ARM920T is, as the "T" suggests, v4t, not v4, hence unaffected. It's 
only pre-Thumb architectures that GCC wants to drop.

Robin.

>
> baruch
>
