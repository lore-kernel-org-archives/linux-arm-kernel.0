From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 18 Oct 2016 17:35:39 +0200
Subject: [PATCH v2 1/4] cpufreq: pxa: use generic platdev driver for
 device-tree
In-Reply-To: <20161018113835.GB11471@vireshk-i7> (Viresh Kumar's message of
 "Tue, 18 Oct 2016 17:08:35 +0530")
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-2-git-send-email-robert.jarzmik@free.fr>
 <20161018113835.GB11471@vireshk-i7>
Message-ID: <87r37d4qlw.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 15-10-16, 21:57, Robert Jarzmik wrote:
>> For device-tree based pxa25x and pxa27x platforms, cpufreq-dt driver is
>> doing the job as well as pxa2xx-cpufreq, so add these platforms to the
>> compatibility list.
>> 
>> This won't work for legacy non device-tree platforms where
>> pxa2xx-cpufreq is still required.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index 0bb44d5b5df4..356825b5c9b8 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -32,6 +32,8 @@ static const struct of_device_id machines[] __initconst = {
>>  	{ .compatible = "fsl,imx7d", },
>>  
>>  	{ .compatible = "marvell,berlin", },
>> +	{ .compatible = "marvell,pxa250", },
>> +	{ .compatible = "marvell,pxa270", },
>>  
>>  	{ .compatible = "samsung,exynos3250", },
>>  	{ .compatible = "samsung,exynos4210", },
>
> Isn't there a race between cpufreq-dt and the platform driver to
> register first ?
Ah, could you be more specific about the race you're talking of ?

My understanding was that cpufreq-dt-platdev does create the device, and
cpufreq-dt is a driver for it, so there is no race but a direct relationship
AFAIU.

> Also, it seems that atleast the next two patches are required before
> applying this? You need to fix the order if that is the case.
Ok, as you wish, let it become number 3 and (2, 3) become (1, 2).

Cheers.

-- 
Robert
