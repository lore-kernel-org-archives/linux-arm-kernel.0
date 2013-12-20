From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 20 Dec 2013 22:55:52 +0530
Subject: [PATCH 01/10] ARM: tegra: Add AS3722 PMIC on Venice2
In-Reply-To: <52B476EA.2040401@wwwdotorg.org>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-2-git-send-email-treding@nvidia.com>
 <52B355EC.9040306@wwwdotorg.org> <52B3E968.8090906@nvidia.com>
 <20131220102542.GJ27787@ulmo.nvidia.com> <52B41FEA.7020608@nvidia.com>
 <52B476EA.2040401@wwwdotorg.org>
Message-ID: <52B47DA0.6040708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 December 2013 10:27 PM, Stephen Warren wrote:
> On 12/20/2013 03:46 AM, Laxman Dewangan wrote:
>> On Friday 20 December 2013 03:55 PM, Thierry Reding wrote:
>>> * PGP Signed by an unknown key
>>>
>>> On Fri, Dec 20, 2013 at 12:23:28PM +0530, Laxman Dewangan wrote:
>>>> On Friday 20 December 2013 01:54 AM, Stephen Warren wrote:
>>>>> On 12/19/2013 09:06 AM, Thierry Reding wrote:
>>>>> (Laxman, as an aside, I'm not sure why you're upstreaming patches that
>>>>> don't exactly match the existing kernel support for this board...)
>>>> I did not get this based on what context it is. Can you please elaborate
>>>> where I am missing the stuff?
>>>>
>>>>
>>>>>> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts
>>>>>> b/arch/arm/boot/dts/tegra124-venice2.dts
>>>>>> +                sd0 {
>>>>>> +                    regulator-name = "vdd_cpu";
>>>>>> +                    regulator-min-microvolt = <700000>;
>>>>>> +                    regulator-max-microvolt = <1350000>;
>>>>> Laxman's patch has:
>>>>>
>>>>>                        regulator-max-microvolt = <1400000>;
>>>> We have the Laguna platform on which Android and L4T is running fine.
>>>> This
>>>> is based on same PMIC used for Venice2. As we are running the more cpu
>>>> stress on Laguna, I took this parameter from the Laguna Power tree
>>>> where it
>>>> is maximum 1.4V. Chrome have maximum as 1.35mV.
>>> Whether this is used on Android, ChromeOS or L4T doesn't matter at all.
>>> It specifies hardware constraints and thus must be agnostic of the OS
>>> and workload.
>>>
>>> Also this file describes the power tree for Venice2, so using values
>>> from Laguna is wrong, no matter how similar they are.
>>>
>> Here, I used term "similar" means the which rail is feeding to Tegra's
>> which vdd?
>> So by this, if AMS SD0 is feeding to Tegra vdd-cpu then it should be
>> same for Laguna.
> Look, this situation is very simple. This file describe Venice2. It
> doesn't matter whether Laguna "should be" similar to Venice2 or not, the
> file needs to describe Venice2 and not Laguna.
>
> Equally, we have a downstream kernel that fully supports Venice2. There
> is therefore absolutely ZERO reason why we should use the downstream
> Laguna board support to create the upstream Venice2 board support,
> rather than using the downstream Venice2 board support to create the
> upstream Venice2 board support.
>
> Please do let me know that you fully understand this issue. If not,
> future patches from you are going to need a heck of a lot more detailed
> review and manual checking, rather than my trusting you got it right.

I like to continue this discussion internally so that we can have proper 
expectations before sending patches.
