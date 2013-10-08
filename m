From: raghavendra.kt@linux.vnet.ibm.com (Raghavendra K T)
Date: Tue, 08 Oct 2013 20:43:03 +0530
Subject: [PATCH 1/2] ARM: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <52541F93.4070503@arm.com>
References: <1381160430-11790-1-git-send-email-marc.zyngier@arm.com>
 <1381160430-11790-2-git-send-email-marc.zyngier@arm.com>
 <CAC4Lta14xZNnEUXxZiaF4=PQQTjq4efjsNDAK2oBH4-Uqh_d0A@mail.gmail.com>
 <5253FDDD.6050008@arm.com> <52541EA3.7010403@linux.vnet.ibm.com>
 <52541F93.4070503@arm.com>
Message-ID: <525420FF.30503@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 08:36 PM, Marc Zyngier wrote:
>>> Just gave it a go, and the results are slightly (but consistently)
>>> worse. Over 10 runs:
>>>
>>> Without RELAX_INTERCEPT: Average run 3.3623s
>>> With RELAX_INTERCEPT: Average run 3.4226s
>>>
>>> Not massive, but still noticeable. Any clue?
>>
>> Is it  a 4x overcommit? Probably we would have hit the code
>> overhead if it were small guests.
>
> Only 2x overcommit (dual core host, quad vcpu guests).

Okay. quad vcpu seem to explain.

>
>> RELAX_INTERCEPT is worth enabling for large guests with
>> overcommits.
>
> I'll try something more aggressive as soon as I get the time. What do
> you call a large guest? So far, the hard limit on ARM is 8 vcpus.
>

Okay. I was referring to guests >= 32 vcpus.
May be 8vcpu guests with 2x/4x is worth trying. If we still do not
see benefit, then it is not worth enabling.
