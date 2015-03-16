From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 16 Mar 2015 21:15:29 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <54FF1BAA.3060409@wwwdotorg.org>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <54FF1BAA.3060409@wwwdotorg.org>
Message-ID: <550739E1.4010607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.03.2015 17:28, Stephen Warren wrote:
> On 03/09/2015 06:21 AM, Sebastian Hesselbarth wrote:
>> I2C mux pinctrl driver currently determines the number of sub-busses by
>> counting available pinctrl-names. Unfortunately, this requires each
>> incarnation of the devicetree node with different available sub-busses
>> to be rewritten.
>>
>> This patch reworks i2c-mux-pinctrl driver to count the number of
>> available sub-nodes instead. The rework should be compatible to the old
>> way of probing for sub-busses and additionally allows to disable unused
>> sub-busses with standard DT property status = "disabled".
>>
>> This also amends the corresponding devicetree binding documentation to
>> reflect the new functionality to disable unused sub-nodes. While at it,
>> also fix two references to binding documentation files that miss an
>> "i2c-"
>> prefix.
>
> The DT binding changes at least,
> Acked-by: Stephen Warren <swarren@nvidia.com>

Wolfram,

are you going to pick this patch through your tree now that Stephen
ack'ed the binding documentation change, too?

I can also split the patch up into driver/doc changes if you prefer.

Sebastian
