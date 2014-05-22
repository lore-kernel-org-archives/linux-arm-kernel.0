From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 22 May 2014 11:56:05 +0200
Subject: [GIT PULL 2/5] Samsung clock updates for 3.16
In-Reply-To: <20140522053126.GF32618@quad.lixom.net>
References: <014501cf73c8$5eb66960$1c233c20$@samsung.com>
 <20140522053126.GF32618@quad.lixom.net>
Message-ID: <537DC9B5.6090405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 22.05.2014 07:31, Olof Johansson wrote:
> On Tue, May 20, 2014 at 10:11:03AM +0900, Kukjin Kim wrote:
>> The following changes since commit 34c453ce16633539a94a2e876faeb731ac1be899:
>>
>>   ARM: S3C24XX: fix merge conflict (2014-05-15 05:54:38 +0900)
>>
>> are available in the git repository at:
>>
>>   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> tags/samsung-clk
>>
>> for you to fetch changes up to 6520e968eef4f88c076a84a80e026049d157132e:
>>
>>   clk: exynos5420: Add 5800 specific clocks (2014-05-19 22:15:08 +0900)
>>
> 
> 1. This is new SoC support -- you said you're sending multiplatform soon so
>    we'll hold off until that's made it in.
> 
> 2. What's the actual dependency here for taking it through arm-soc? Seems like
>    nearly all of it is in drivers/clk.

This is a complicated network of dependencies:

 1) s3c24xx conversion to CCF had dependencies on Kukjin's tree so it
was applied there,
 2) support for multiple clock providers in Samsung clock library needed
to convert s3c24xx clock driver (applied to Kukjin's tree) as well,
 3) due to quite invasive nature of the series above, most of the
patches touching Samsung clock drivers ended depending on it, due to
multiple conflicts otherwise.

Best regards,
Tomasz
