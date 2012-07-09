From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 9 Jul 2012 14:32:20 +0200
Subject: [PATCH v4 3/5] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <CAMQu2gydOEVK_fzmzkdrBwBfOq6eZG=0QfLUfFChWJu9unSn2A@mail.gmail.com>
References: <1341826026-6504-1-git-send-email-vincent.guittot@linaro.org>
 <1341826026-6504-4-git-send-email-vincent.guittot@linaro.org>
 <CAMQu2gydOEVK_fzmzkdrBwBfOq6eZG=0QfLUfFChWJu9unSn2A@mail.gmail.com>
Message-ID: <CAKfTPtDPGPNk2h_zB=Rf2N2UABAgaDBbij5QFoZTxUTZJbTeAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 July 2012 12:55, Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
> Vincent,
> On Mon, Jul 9, 2012 at 2:57 PM, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>> Use cpu compatibility field and clock-frequency field of DT to
>> estimate the capacity of each core of the system and to update
>> the cpu_power field accordingly.
>> This patch enables to put more running tasks on big cores than
>> on LITTLE ones. But this patch doesn't ensure that long running
>> tasks will run on big cores and short ones on LITTLE cores.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>  arch/arm/kernel/topology.c |  153 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 153 insertions(+)
>>
> Sorry for not giving this comment on previous version but we should also
> have a way to provide the big.LITTLE information without Device Tree.
> May be a platform device/data.

Hi Santosh,

I had thought of adding such additional way to set cpu_power of
big.LITTLE but my conclusion was
-it's a new platform so it should come with DT
-DT is already required by other patches linked to big.LITTLE
(http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/080873.html)
-There is no device that can be easily used to get such information at
this early boot stage.

>
> I know we are moving DT way, but remember apart from core kernel
> infrastructure, to have a complete product build with DT means all the
> drivers must be already supporting DT which is not the case with
> many huge driver sub-systems like USB, display subsystem, Audio etc.
>
> Having that support would greatly help for the SOC's which have not yet
> reached to stage where entire SOC is DT compliant and want to use
> big.LITTLE infrastructure.

Can't you support both type of devices on your platform ? You can move
your device to DT mode when it is supported ?

Regards,
Vincent

>
> Regards
> Santosh
