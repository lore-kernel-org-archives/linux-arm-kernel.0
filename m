From: stefan@agner.ch (Stefan Agner)
Date: Thu, 05 Dec 2013 18:33:20 +0100
Subject: [PATCH v4 3/3] ARM: tegra: correct Colibri T20 regulator settings
In-Reply-To: <52A0B40B.7040903@wwwdotorg.org>
References: <cover.1386108712.git.stefan@agner.ch>
 <fc7440a2f4bf9ab95e47a911c0e0b3b6a2250356.1386108712.git.stefan@agner.ch>
 <52A0B40B.7040903@wwwdotorg.org>
Message-ID: <e2fe1d7b546e9f81fdd1ad225676e76e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-12-05 18:12, schrieb Stephen Warren:
> On 12/03/2013 03:18 PM, Stefan Agner wrote:
>> Set the parent of the regulators LDO2 to LDO9 according to the
>> schematic. Set the base voltage to 3.3V, there is only 3.3V on the
>> module itself.
>>
>> Set the Core and CPU voltage to the specified voltages of 1.2V and
>> 1.0V respectivly.
>>
>> LDO6 should deliver 2.85V. The attached peripherals were not in
>> use so far.
> 
> Does this depend on patch 1/3 or 2/3, or can I apply it to the Tegra
> tree which doesn't include those patches?

This patch is independent from 1/3 and 2/3, so you can apply it to the
Tegra tree. The relevant DT change for 2/3 is included in 2/3...
