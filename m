From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Mar 2015 10:57:18 +0100
Subject: [RFC PATCH v15 04/11] ARM: cpuidle: Register cpuidle_ops for
 QCOM cpus
In-Reply-To: <20150312150655.GA497@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
 <1425914206-22295-5-git-send-email-lina.iyer@linaro.org>
 <5500866F.6080704@codeaurora.org> <550187C0.4020006@linaro.org>
 <20150312150655.GA497@linaro.org>
Message-ID: <5502B47E.4010106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2015 04:06 PM, Lina Iyer wrote:
> On Thu, Mar 12 2015 at 06:34 -0600, Daniel Lezcano wrote:
>> On 03/11/2015 07:16 PM, Stephen Boyd wrote:
>>> On 03/09/15 08:16, Lina Iyer wrote:
>
> [...]
>
>>>> +#if IS_ENABLED(CONFIG_QCOM_PM)
>>>
>>> Why not #ifdef CONFIG_QCOM_PM? I thought IS_ENABLED was for C code where
>>> you want to put it in an if () statement.
>>
>> This is right. But the IS_ENABLED is also valid.
>>
>> It seems the current trend is to replace #ifdef with #if IS_ENABLED.
>> It is supposed to prevent to create or'ed conditional with the module
>> support.
>>
>> eg:
>>
>> #if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE)
>>
>> is replaced by:
>>
>> #if IS_ENABLED(CONFIG_FOO)
>>
>> Lina: By the way, it would be preferable to use the
>> CONFIG_ARM_QCOM_CPUIDLE where IS_ENABLED makes more sense even the
>
> Daniel: I dont have CONFIG_ARM_QCOM_CPUIDLE defined anymore. By moving
> to generic ARM cpuidle, i removed all changes to drivers/cpuidle/. So I
> used the config item that defineds these items.
>
> Also, having two indpendent CONFIG_ items provides a chance that the
> declaration is not matched with the definition or vice versa.

I think CONFIG_ARM_QCOM_CPUIDLE should be defined as a bool in the 
Kconfig.arm in drivers/cpuidle.

We may want to disable the different cpuidle drivers even if they rely 
on the generic cpuidle driver.

>> drivers are not modules (who knows if they are converted as module
>> again hence #ifdef will be invalid).
>>
>>
>>
>>>> +CPUIDLE_OPS(qcom_kpss_v1)
>>>> +CPUIDLE_OPS(qcom_kpss_v2)
>>>> +#endif
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
