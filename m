From: stefan@agner.ch (Stefan Agner)
Date: Fri, 06 Dec 2013 16:00:26 +0100
Subject: [PATCH v5 1/3] mfd: tps6586x: add version detection
In-Reply-To: <20131206142605.GA32363@ulmo.nvidia.com>
References: <cover.1386333697.git.stefan@agner.ch>
 <7812fb79beac0a6a409090f43d129893f9f93b5b.1386333697.git.stefan@agner.ch>
 <20131206142605.GA32363@ulmo.nvidia.com>
Message-ID: <5e063ab19c8fb9754216189c65d8f670@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-12-06 15:26, schrieb Thierry Reding:
> On Fri, Dec 06, 2013 at 01:51:45PM +0100, Stefan Agner wrote:
>> Use the VERSIONCRC to determine the exact device version. According to
>> the datasheet this register can be used as device identifier. The
>> identification is needed since some tps6586x regulators use a different
>> voltage table.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Changes since v4:
>>   - Use variable named version instead of ret
>>
>> Changes since v2:
>>   - Avoid moving devm_kzalloc
>> ---
>>  drivers/mfd/tps6586x.c       | 50 +++++++++++++++++++++++++++++++++++++-------
>>  include/linux/mfd/tps6586x.h |  7 +++++++
>>  2 files changed, 49 insertions(+), 8 deletions(-)
> 
> I think I also already gave my Reviewed-by on both this and 2/3, neither
> of which changed significantly enough to warrant that to be dropped. In
> general it's fine to keep Reviewed-by and Acked-by as long as you're
> only changing minor things.
> 
> Thierry

Ok, sorry, didn't realize that is my job to pick them up when doing new
revisions. Lee, can you add this when you apply this patch?

Reviewed-by: Thierry Reding <treding@nvidia.com>
