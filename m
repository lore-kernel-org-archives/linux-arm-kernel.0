From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 11 Oct 2013 21:23:25 +0300
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
In-Reply-To: <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
 <525654AE.7060009@ti.com>
 <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com>
Message-ID: <5258421D.8030006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2013 08:54 PM, Paul Walmsley wrote:
> On Thu, 10 Oct 2013, Tero Kristo wrote:
>
>> On 10/09/2013 09:59 PM, Paul Walmsley wrote:
>>> Eh, one correction:
>>>
>>> On Wed, 9 Oct 2013, Paul Walmsley wrote:
>>>
>>>> We could easily wind up with kernels that won't boot at all when used
>>>> with newer DT data.
>>>
>>> This is a misstatement of the issue: the concern here is that newer
>>> kernels may not boot at all with older DT data - which could easily be in
>>> locked areas of the flash or firmware.
>>
>> I wonder who would be crazy enough to put DT data into a locked area, and to
>> what purpose. If you can update the kernel, there is no point locking down DT
>> data, this will just cause you unnecessary misery.
>
> The DT data will be used by bootloaders also :-(
>
> In situations where the bootloaders are signed and locked, the security
> people are also insisting that the DT data be signed and locked.

Well, even if you sign something, you can still update it. Writing any 
software to true OTP memory is one way to commit suicide IMO. How many 
nasty bugs have you seen with ROM code? Also, if people want to make 
their custom security solutions which are not supported by the kernel, 
why should the kernel care about it? We don't know the details, and 
can't influence the design, so we can't prepare for it anyway.

-Tero
