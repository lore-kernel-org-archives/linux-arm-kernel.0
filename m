From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 16 Sep 2015 07:25:51 +0200
Subject: [PATCH v4 3/5] dt/bindings: bcm2835: add binding documentation
 for bcm2835-aux
In-Reply-To: <55F8EC22.7020909@wwwdotorg.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
 <1440405608-3995-4-git-send-email-kernel@martin.sperl.org>
 <55DD1A13.7010705@wwwdotorg.org>
 <9D45476C-88E2-4F76-AB55-9D0C7194E29C@martin.sperl.org>
 <55F8EC22.7020909@wwwdotorg.org>
Message-ID: <77103FCE-5756-45AF-B764-310E51097781@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 16.09.2015, at 06:12, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> On 09/04/2015 01:26 AM, Martin Sperl wrote:
>> 
>>> On 26.08.2015, at 03:44, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> 
>>> On 08/24/2015 02:40 AM, kernel at martin.sperl.org wrote:
>>> 
>>>> +Example:
>>>> +
>>>> +aux_enable: aux_enable at 0x7e215004 {
>>>> +	compatible = "bcrm,bcm2835-aux";
>>>> +	reg = <0x7e215004 0x04>;
>>> 
>>> I'd expect that to be <0x7e215000 0x8>;
>> 
>> The reason is that we just handle enable with this driver,
>> which just requires access to the 0x7e215004 register.
>> 
>> The 0x7e215000 register (interrupt mask) could be used by a
>> cascaded interrupt-controller, but as the spi and uart drivers
>> can run with shared interrupts this is not a necessity.
> 
> The DT is supposed to describe the HW, not any particular SW's use of
> the HW. If the HW block has 2 registers, so must the DT reg property.

Please look at V6 of the patch-series, that uses Erics clock-patch.
