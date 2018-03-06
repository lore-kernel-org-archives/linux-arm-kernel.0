From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 6 Mar 2018 16:52:09 +0000
Subject: [PATCH v2 0/6] Arm interconnect PMU driver tidyup
In-Reply-To: <CAK8P3a1fSYaAQHoESQc8y3Xn+5bAg6dFtjnz1nayfhrpns+ZGg@mail.gmail.com>
References: <cover.1518717258.git.robin.murphy@arm.com>
 <CAK8P3a1fSYaAQHoESQc8y3Xn+5bAg6dFtjnz1nayfhrpns+ZGg@mail.gmail.com>
Message-ID: <793b9205-1d81-ce05-bdab-6bf0c0db59ba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 06/03/18 16:38, Arnd Bergmann wrote:
> On Thu, Feb 15, 2018 at 7:51 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> Hi arm-soc folks,
>>
>> PLease consider this series tidying up the Arm interconnect code
>> in drivers/bus to separate the PMU parts out into drivers/perf
>> where Will and Mark can handle future maintenance more easily.
>>
>> FWIW, the patches are also available on a branch here:
>>
>>    git://linux-arm.org/linux-rm.git perf
> 
> This is not a signed tag, so I applied the patches manually to the drivers

Yes, that was merely a convenience branch for reviewers; I see actual 
pull requests as being for maintainers, whereas I'm just some oik ;)

> branch. To add to the bike-shedding, I would have preferred a different
> approach over the auxdata array, either exporting a function based
> interface, or calling ioremap() on the physical address multiple times,
> but each of those has other downsides, so your version seems good
> enough.

Yeah, all of the options were pretty horrible, but this one was about 
the most concise and didn't need to introduce any new infrastructure. We 
have this "PMU as a child of some other device" issue coming up on 
various other IP blocks as well; the resource claiming conflicts seem to 
get in the way the most.

Thanks for applying!

Robin.
