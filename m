From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Fri, 8 May 2015 21:17:12 +0300
Subject: [PATCH v2 2/2] arm64: dts: qcom: Add msm8916 CoreSight components
In-Reply-To: <20150508180052.GD11680@leverpostej>
References: <1431012969-16338-1-git-send-email-ivan.ivanov@linaro.org>
 <1431012969-16338-3-git-send-email-ivan.ivanov@linaro.org>
 <CANLsYkzNXBH0d6v1Ny_JwpW6NcKr9v0oAi9K3YfipwDgHWfMMA@mail.gmail.com>
 <1431092877.21307.18.camel@linaro.org> <20150508180052.GD11680@leverpostej>
Message-ID: <B19B6A91-0CF2-428B-8CAC-FFEDD5D3D094@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On May 8, 2015, at 9:00 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> On Fri, May 08, 2015 at 02:47:57PM +0100, Ivan T. Ivanov wrote:
>> 
>> On Fri, 2015-05-08 at 07:38 -0600, Mathieu Poirier wrote:
>>> On 7 May 2015 at 09:36, Ivan T. Ivanov ivanov at linaro.org> wrote:
>>>> Add initial set of CoreSight components found on Qualcomm's 8x16 chipset.
>>>> 
>>>> 
>>>> +       replicator at 824000 {
>>>> +               compatible = "qcom,coresight-replicator", "arm,primecell";
>>> 
>>> Shouldn't it be "qcom,coresight-replicator1x" ?
>>> 
>> 
>> 
>> 
>> True, I still wonder, why we have to have this compatible string? 
>> Drivers are probed by amba_id and "arm,primecell", after all.
> 
> The compatible string tells you both the device _and_ the format of the
> other properties, because it tells you which binding applies.
> 
> So the compatible string should be present regardless, as
> "arm,primecell" does not define the majority of the properties you need
> for the replicator node.

Mmm, only if vendors don?t bother to update version information
fused to revision id registers, which happens. And this could 
be workaround by "arm,primecell-periphid?, no?

Regards,
Ivan
