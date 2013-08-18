From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Aug 2013 03:05:29 +0900
Subject: [PATCH V5] ARM: dts: Change i2s compatible string on exynos5250
In-Reply-To: <1812843.09c8C6xn0E@flatron>
References: <1376627178-28649-1-git-send-email-padma.v@samsung.com>
 <CAOesGMj4y=uVMmETLXs_1ZfTD+CrQgKuirrpGrqs=CU3uk5__Q@mail.gmail.com>
 <13f801ce9a43$823571b0$86a05510$@org> <1812843.09c8C6xn0E@flatron>
Message-ID: <52110CE9.8000100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/13 16:53, Tomasz Figa wrote:
> Hi Kukjin,
>
[...]

>>>> -               compatible = "samsung,i2s-v5";
>>>> +               compatible = "samsung,s5pv210-i2s";
>>>
>>> Device tree reviewers, this is something to look out for in the
>>> future. Some samsung platforms/drivers use "samsung,<chip>-<ip>",
>>> others "samsung,<ip>-<chip>". I don't personally care much one way or
>>> another, but it really should be consistent.
>>
>> Hmm...I think, if "samsung,<ip name>-<ip version>" is possible, it would
>> be nice. I remember there are no versions in datasheet for some IPs but
>> something have like i2s and mfc. So "samsung,<ip>-<version>" is used
>> for only i2s and mfc. But actually there are versions for Samsung IPs,
>> no comments for that in datasheet. So I think, if Samsung can provide
>> the specific version of Samsung IPs, we can use that like other
>> platforms. I will prepare some table for that after meeting with
>> Samsung hardware IP team so that samsung platform use one format
>> "samsung,<ip>-<version>".
>
> Sorry, I don't think this is a good idea, unless you can force the IP team
> to release a version table containing version of _every_ IP for _every_
> released SoC, including those historical ones, like S3C24xx and S3C64xx.
> Of course such tables should be available publicly.
>
It's different issue and I agree with Mark Brown's comments.

> In addition, there might be other funny things going on with IPs and their
> surroundings, that could make a need to create several separate compatible
> values for the same IP revision, but on different SoCs, because it was
> integrated in a slightly different way.
>
> I believe we have choses the "samsung,<chip>-<ip>" scheme to avoid being
> dependent upon data that is not always publicly available, which is more
> future- (and past-) proof and also solves the integration problem.
>
Well, I don't think so, because Samsung is no more just SoC vendor. 
Actually Samsung is providing just IP to customers, I think, they don't 
like to use the name, exynos**** for their SoC or Chip, because exynos, 
s3c or s5p whatever is Samsung's SoC brand name. If so, I think, my 
suggestion is more reasonable. See the example of Synopsys and ARM 
primecell...that's why I will try to do it. But I know I need to get 
agreement from DT guys and maybe I need more time than I expect ;-)

Thanks,
Kukjin
