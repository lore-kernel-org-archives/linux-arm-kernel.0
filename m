From: stefan@agner.ch (Stefan Agner)
Date: Wed, 08 Jun 2016 14:47:49 -0700
Subject: [PATCH v2 2/5] mfd: add Ricoh RN5T567 PMIC support
In-Reply-To: <20160608202257.GA22463@rob-hp-laptop>
References: <20160608010429.19618-1-stefan@agner.ch>
 <20160608010429.19618-3-stefan@agner.ch>
 <20160608202257.GA22463@rob-hp-laptop>
Message-ID: <b4713d7dadd2572eb66ad6b836a72e82@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-06-08 13:22, Rob Herring wrote:
> On Tue, Jun 07, 2016 at 06:04:26PM -0700, Stefan Agner wrote:
>> The Ricoh RN5T567 is from the same family as the Ricoh RN5T618 is,
>> the differences are:
>>
>> + DCDC4
>> + Slightly different output voltage/currents
>> + 32kHz Output
>> - ADC/Charger capabilities
>>
>> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  Documentation/devicetree/bindings/mfd/rn5t618.txt | 19 ++++++++++-------
>>  drivers/mfd/Kconfig                               |  7 +++---
>>  drivers/mfd/rn5t618.c                             | 26 +++++++++++++++++------
>>  include/linux/mfd/rn5t618.h                       | 12 +++++++++++
>>  4 files changed, 46 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
>> index 937785a..5b493ed 100644
>> --- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
>> +++ b/Documentation/devicetree/bindings/mfd/rn5t618.txt
>> @@ -1,18 +1,21 @@
>> -* Ricoh RN5T618 PMIC
>> +* Ricoh RN5T567/RN5T618 PMIC
>>
>> -Ricoh RN5T618 is a power management IC which integrates 3 step-down
>> -DCDC converters, 7 low-dropout regulators, a Li-ion battery charger,
>> -fuel gauge, ADC, GPIOs and a watchdog timer. It can be controlled
>> -through a I2C interface.
>> +Ricoh RN5T567/RN5T618 is a power management IC family which integrates
>> +3 to 5 step-down DCDC converters, 7 low-dropout regulators, GPIOs and
> 
> I count 4?

There is actually a third PMIC in this family RC5T619 which has 5, that
is where the number comes from. But that PMIC also has 12 LDO's so the
numbers are a bit a mix and much right now...

If I have to amend something anyway, I will fix that. Otherwise I look
at it as a preparation for the one which adds RC5T619 support :-)

--
Stefan
