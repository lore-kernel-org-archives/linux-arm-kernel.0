From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 20 Feb 2018 09:36:10 +0000
Subject: [alsa-devel] [PATCH v3 14/25] ASoC: qcom: qdsp6: Add support to
 q6afe dai driver
In-Reply-To: <84723548-02a4-10e7-3de1-b347416d4fb0@codeaurora.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-15-srinivas.kandagatla@linaro.org>
 <84723548-02a4-10e7-3de1-b347416d4fb0@codeaurora.org>
Message-ID: <f5aed3f1-d037-861b-5efd-d6abd8cf7e6e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for testing this out,

On 19/02/18 10:32, Rohit Kumar wrote:
>>
>> diff --git a/sound/soc/qcom/qdsp6/Makefile 
>> b/sound/soc/qcom/qdsp6/Makefile
>> index 660afcab98fd..c7833842b878 100644
>> --- a/sound/soc/qcom/qdsp6/Makefile
>> +++ b/sound/soc/qcom/qdsp6/Makefile
>> @@ -1,5 +1,5 @@
>>   obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
>> -obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
>> +obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o q6afe-dai.o
> depmod: ERROR: Cycle detected: q6afe -> q6afe_dai -> q6afe
> need to use like:
> +qdsp6_afe-objs := q6afe.o q6afe-dai.o
> +obj-$(CONFIG_SND_SOC_QDSP6_AFE) += qdsp6_afe.o
> similarly for asm and adm


Yep, will fix this in next version,

thanks,
srini
>>   obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o q6routing.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
>> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c 
>> b/sound/soc/qcom/qdsp6/q6afe-dai.c
>> new file mode 100644
>> index 000000000000..f6a618e9db9e 
