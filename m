From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Aug 2013 15:13:05 -0600
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <56FE58B8-1619-4CDF-A5E6-89CE6F51E96C@codeaurora.org>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <520BF152.1020704@wwwdotorg.org>
 <56FE58B8-1619-4CDF-A5E6-89CE6F51E96C@codeaurora.org>
Message-ID: <520BF2E1.8070805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 03:09 PM, Kumar Gala wrote:
> 
> On Aug 14, 2013, at 4:06 PM, Stephen Warren wrote:
> 
>> On 07/23/2013 03:19 AM, Punit Agrawal wrote:
>>> The CCI PMU can profile bus transactions at the master and slave
>>> interfaces of the CCI. The PMU can be used to observe an aggregated view
>>> of the bus traffic between the various components connected to the CCI.
>>>
>>> Extend the existing CCI driver to support the PMU by registering a perf
>>> backend for it.
>>>
>>> Document the device tree binding to describe the CCI PMU.
>>
>>> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
>>
>>> +	- CCI PMU node
>>> +
>>> +		Node name must be "pmu".
>>
>> I don't think the binding should require the node to have a particular
>> name; node names shouldn't be interpret/used/relied-upon by drivers.
> 
> While I agree with that, we should be aiming for some convention and consistency with node names.

Sure. Should there be a Documentation/devictree/bindings/node-names that
lists common node names for people to use? Either way though, I still
think this is an aspect of authoring the *.dts file, not an aspect of
the DT binding? After all, what if there were more than one CCI so they
needed to be named pmu at 0, pmu at 1, etc.?
