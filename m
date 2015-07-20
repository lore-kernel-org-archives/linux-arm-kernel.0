From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 20 Jul 2015 12:12:22 +0200
Subject: [PATCH v2 1/4] mfd: max77686: Don't suggest in binding to use a
 deprecated property
In-Reply-To: <20150720081020.GD3061@x1>
References: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
 <1437114567-17629-2-git-send-email-javier@osg.samsung.com>
 <20150720081020.GD3061@x1>
Message-ID: <55ACC986.5040408@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

Thanks a lot for your feedback.

On 07/20/2015 10:10 AM, Lee Jones wrote:
> On Fri, 17 Jul 2015, Javier Martinez Canillas wrote:
> 
>> The regulator-compatible property from the regulator DT binding was
>> deprecated. But the max77686 DT binding doc still suggest to use it
>> instead of the regulator node name's which is the correct approach.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> By convention shouldn't this be buck at 1, or something?
>
> Need Mark to look at this.
>

That's a very good question, the ePAPR doc says:

"The unit-address must match the first address specified in the reg property
of the node. If the node has no reg property, the @ and unit-address must be
omitted and the node-name alone differentiates the node from other nodes at
the same level in the tree"

This PMIC uses a single I2C address for all the regulators and these are
controlled by writing to different I2C register addresses. So the regulator
nodes don't have a reg property in this case.

By looking at other regulators bindings, besides the generic regulator.txt
and fixed-regulator.txt DT bindings, there are only 5 (out of 40) that use
the node-name at unit-address convention mentioned in the ePAPR document.

AFAICT all these are for regulators that are actually in different addresses
but I could be wrong so let's see what Mark says.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
