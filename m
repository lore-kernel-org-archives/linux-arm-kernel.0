From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 29 Sep 2014 09:04:41 -0600
Subject: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <542934FE.1060506@smartplayin.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
 <542934FE.1060506@smartplayin.com>
Message-ID: <20140929150441.GB1170@ilina-mac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29 2014 at 04:27 -0600, Pramod Gurav wrote:
>Hi Lina
>
>One sections mismatch warning here as well:
>
>WARNING: drivers/cpuidle/built-in.o(.text+0x2740): Section mismatch in
>reference from the function qcom_cpuidle_probe() to the (unknown
>reference) .init.rodata:(unknown)
>The function qcom_cpuidle_probe() references
>the (unknown reference) __initconst (unknown).
>This is often because qcom_cpuidle_probe lacks a __initconst
>annotation or the annotation of (unknown) is wrong.
>

Thanks, will fix it.

>On Saturday 27 September 2014 06:28 AM, Lina Iyer wrote:
>> Add cpuidle driver interface to allow cpus to go into C-States. Use the
>> cpuidle DT interface common across ARM architectures to provide the
>> C-State information to the cpuidle framework.
>>
>>
>
>..
>
>> +};
>> +
>> +static const struct of_device_id qcom_idle_state_match[] __initconst = {
>This is causing it.
>
>> +	{ .compatible = "qcom,idle-state-wfi", .data = qcom_lpm_enter_wfi },
>> +	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
>> +	{ },
>> +};
>> +
>Thanks
>Pramod
>
