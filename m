From: daniel@zonque.org (Daniel Mack)
Date: Wed, 19 Sep 2018 18:20:38 +0200
Subject: [PATCH] arm: dts: pxa3xx: provide correct clk-names property for
 nand controller node
In-Reply-To: <87po0emxhg.fsf@belgarion.home>
References: <20180624174205.20648-1-daniel@zonque.org>
 <87po0emxhg.fsf@belgarion.home>
Message-ID: <f3e704f5-a5ac-ea4a-65f2-9dc11a67c9f2@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 25/6/2018 10:18 PM, Robert Jarzmik wrote:
> Daniel Mack <daniel@zonque.org> writes:
> 
>> The NAND driver looks for a clock named "core" and falls back to a pdev
>> clock that has a wrong rate if not set.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Applied to pxa/dt with a small "line swap", ie. clock-names is one line below
> "clocks" line.

This patch got applied twice in mainline, as ce4313f318de and as 
267a113cec97. Not sure what went wrong here, but the same property npow 
occurs twice in the node, which leads to an error during dtb complication.

Could you queue a revert for ce4313f318de?


Thanks,
Daniel
