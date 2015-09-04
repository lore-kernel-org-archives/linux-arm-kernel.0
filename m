From: kernel@martin.sperl.org (Martin Sperl)
Date: Fri, 4 Sep 2015 10:26:21 +0200
Subject: [PATCH v4 3/5] dt/bindings: bcm2835: add binding documentation
 for bcm2835-aux
In-Reply-To: <55DD1A13.7010705@wwwdotorg.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
 <1440405608-3995-4-git-send-email-kernel@martin.sperl.org>
 <55DD1A13.7010705@wwwdotorg.org>
Message-ID: <9D45476C-88E2-4F76-AB55-9D0C7194E29C@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 26.08.2015, at 03:44, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> On 08/24/2015 02:40 AM, kernel at martin.sperl.org wrote:
> 
>> +Example:
>> +
>> +aux_enable: aux_enable at 0x7e215004 {
>> +	compatible = "bcrm,bcm2835-aux";
>> +	reg = <0x7e215004 0x04>;
> 
> I'd expect that to be <0x7e215000 0x8>;

The reason is that we just handle enable with this driver,
which just requires access to the 0x7e215004 register.

The 0x7e215000 register (interrupt mask) could be used by a
cascaded interrupt-controller, but as the spi and uart drivers
can run with shared interrupts this is not a necessity.

Martin
