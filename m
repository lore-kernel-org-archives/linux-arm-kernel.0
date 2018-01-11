From: david@lechnology.com (David Lechner)
Date: Thu, 11 Jan 2018 15:51:45 -0600
Subject: [PATCH v5 17/44] dt-bindings: clock: Add bindings for DA8XX
 CFGCHIP gate clocks
In-Reply-To: <20180111214516.quplp3kwwfrzocfp@rob-hp-laptop>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-18-git-send-email-david@lechnology.com>
 <20180111214516.quplp3kwwfrzocfp@rob-hp-laptop>
Message-ID: <fa5f1bff-42e7-0c1e-5f35-58493336ee74@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 03:45 PM, Rob Herring wrote:
> On Sun, Jan 07, 2018 at 08:17:16PM -0600, David Lechner wrote:
>> This adds a new binding for the gate clocks present in the CFGCHIP syscon
>> registers in TI DA8XX SoCs. There are actually other gate clocks in this
>> block that could be added in the future, but TBCLK is currently the only
>> one being used.
> 
> Like how many? 2 more?, then fine. 20 more, then perhaps cfgchip should
> be the clock provider.

Like, one more. Same goes for the mux clock. The USB PHY clocks are also
part of the CFGCHIP.

All of these clocks are randomly spread out, so I didn't really see a logical
way to make a single clock provider with #clock-cells = <1>.

> 
> In any case, I'd prefer to see all the cfgchip clocks documented in one
> doc.

I will do that.
