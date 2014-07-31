From: xuwei5@hisilicon.com (xuwei)
Date: Thu, 31 Jul 2014 10:00:26 +0800
Subject: [PATCH v5 0/8] enable Hisilicon HIX5HD2 SoC
In-Reply-To: <CAOesGMj26SCnaOrRkvS=9t_CkOLK=pyJdqV0rxFXnfxt3E30kQ@mail.gmail.com>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>	<20140729064027.GE32359@quad.lixom.net>	<53D756B4.50907@hisilicon.com>
 <CAOesGMj26SCnaOrRkvS=9t_CkOLK=pyJdqV0rxFXnfxt3E30kQ@mail.gmail.com>
Message-ID: <53D9A33A.20304@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/7/31 9:06, Olof Johansson wrote:
> Hi,
> 
> On Tue, Jul 29, 2014 at 1:09 AM, xuwei <xuwei5@hisilicon.com> wrote:
>>
>>
>> On 2014/7/29 14:40, Olof Johansson wrote:
>>> On Mon, Jul 28, 2014 at 08:51:15PM +0800, Haojian Zhuang wrote:
>>>> Changelog:
>>>> v5:
>>>>   * Use CPU_OF_DECLARE_METHOD().
>>>>   * State "hisilicon,cpuctrl" in documents.
>>>>   * Set PL310 L2 aux value in machine descriptor.
>>>>   * Use enable-method property for smp in dts file.
>>>>   * Move reset code from machine platform driver into power reset driver.
>>>>   * Move HIP04 debug uart into another patch series.
>>>
>>> Usually there's some more description in the cover letter than just the
>>> changelog.
>>
>> Hi Olof,
>>
>>> Anyway, my question is this: what's the plan for upstreaming of this SoC? Is it
>>> a mobile-only SoC, or has it been used (or will it be used) in other embedded
>>> use cases, public development boards and the like?
>>
>> HiX5HD2 is for the STB market.
>> Hisilicon has already made some public development boards for Linaro and hope
>> it could be used in Linaro Home Group.
>> And if you are interesting about it, we could send one to you.
>>
>> There are several phases for upstreaming of this SoC.
>> At the first phase, it includes the basic SoC(earlycon, gic, timer, L2 cache,
>> SMP and reboot), net, emc, USB and clock.

Hi Olof,
 
> I am mostly asking because I want to get a feel for whether you will
> complete upstreaming, or just upstream the minimal set of platform
> support that won't actually be useful for anyone (like with what's
> already in the tree).

> For a STB chip, display is critical. Do you have a DRM driver planned?

I know what you are concerned.
We indeed want to complete upstreaming.
Because we also could not get any profit from the minimal set.
We have already set up a team for upstreaming.

About the DRM driver, we are still changing the source code.
Once it is done, we will start upstreaming it.

> 
>>> If it is a mobile-targeted product, what is the plan and rough timeline
>>> for upstreaming things such as display/graphics and power management
>>> components?
>>
>> About the display/graphics/video/audio, we are still discussing how to upstream.
>> There are two limitations. One is the code we have now does not adapt with kernel.
>> The other is the policy of company which part is allowed to upstream.
> 
> This sounds odd. Are they shipping this chip in products today? If so,
> they already have to publish GPL sources, so "allowed" to upstream is
> a very odd limitation.

Yes. There are already some companies use this SoC on their product.
We follow the GPL licenses and the sources are open for our clients.
And the "allowed" here means it depend on the strategy of our company
how many parts to upstream.

And as the info in Haojian's reply, we are pushing the usptreaming.

Best Regards,
Wei

>> But anyway, we hope we could do upstreaming.
> 
> Ok. I would very much like to see successful upstreaming of hisilicon
> platforms to happen, but the track record so far hasn't been very
> promising. If you think you'll get all the way and make the platform
> useful, then that's a great sign. I am very concerned about lack of
> graphics plans though.
> 
> 
> Thanks,
> 
> -Olof
> 
> .
> 
