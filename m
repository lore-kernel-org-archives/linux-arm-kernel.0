From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 28 Jun 2017 18:53:52 +0100
Subject: [PATCH v2 03/12] coresight: Extend the PIDR mask to cover
 relevant bits in PIDR2
In-Reply-To: <CANLsYkwHvxZmRSRYvkAoq2JMnrJ8OVcRdtt0s8YYQmN6gT1jKw@mail.gmail.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
 <1498490576-1350-4-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkwHvxZmRSRYvkAoq2JMnrJ8OVcRdtt0s8YYQmN6gT1jKw@mail.gmail.com>
Message-ID: <1629d248-2b4d-8c1f-f30b-30c02709b63b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/17 18:35, Mathieu Poirier wrote:
> On 26 June 2017 at 09:22, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> As per coresight standards, PIDR2 register has the following format :
>>
>>  [2-0]  - JEP106_bits6to4
>>  [3]    - JEDEC, designer ID is specified by JEDEC.
>>
>> However some of the drivers only use mask of 0x3 for the PIDR2 leaving
>> bits [3-2] unchecked, which could potentially match the component for
>> a different device altogether. This patch fixes the mask and the
>> corresponding id bits for the existing devices.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> I have not touched the TPIU ids for Ux500 (see commit: 4339b699),
>> as I don't have a platform to fix/correct the ids.
>> ---
>>  .../coresight/coresight-dynamic-replicator.c       |  4 ++--
>>  drivers/hwtracing/coresight/coresight-etb10.c      |  4 ++--
>>  drivers/hwtracing/coresight/coresight-etm3x.c      | 24 +++++++++++-----------
>>  drivers/hwtracing/coresight/coresight-funnel.c     |  4 ++--
>>  drivers/hwtracing/coresight/coresight-stm.c        |  8 ++++----
>>  drivers/hwtracing/coresight/coresight-tmc.c        |  4 ++--
>>  drivers/hwtracing/coresight/coresight-tpiu.c       |  4 ++--
>>  7 files changed, 26 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> index 1675031..57babd8 100644
>> --- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> +++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> @@ -177,8 +177,8 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
>>
>>  static struct amba_id replicator_ids[] = {
>>         {
>> -               .id     = 0x0003b909,
>> -               .mask   = 0x0003ffff,
>> +               .id     = 0x000bb909,
>> +               .mask   = 0x000bffff,
>
> Shouldn't this be 0x000fffff rather than 0x000bffff?

Yes, you're right. Thanks for spotting the typo. Will fix it.

Suzuki
