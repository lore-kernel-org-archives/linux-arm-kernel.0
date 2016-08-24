From: daniel@zonque.org (Daniel Mack)
Date: Wed, 24 Aug 2016 13:01:44 +0200
Subject: [PATCH v3 0/2] AM335x-ICE: Add support for rotary switch
In-Reply-To: <5294e820-4946-a196-549f-76a349b6606d@ti.com>
References: <20160824075859.30979-1-vigneshr@ti.com>
 <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
 <5294e820-4946-a196-549f-76a349b6606d@ti.com>
Message-ID: <86711a29-8fb5-9804-8642-2f390081e677@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2016 11:15 AM, Vignesh R wrote:
> On Wednesday 24 August 2016 02:05 PM, Daniel Mack wrote:
>> On 08/24/2016 09:58 AM, Vignesh R wrote:
>>> This series adds support for rotary-switch on AM335x-ICE that is
>>> connected to TI PCA9536 I2C GPIO expander.
>>> First patch adds new generic driver to read status of group of GPIO
>>> lines and report the value as an input event. The second patch adds DT
>>> entries for the same.
>>>
>>> v2: https://lkml.org/lkml/2016/8/23/111
>>> v1: https://lkml.org/lkml/2016/8/12/7
>>
>> Is there a reason why the rotary-encoder driver cannot handle this?
>> Commit 7dde4e74744 ("Input: rotary-encoder - support more than 2 gpios
>> as input") added support for that mode AFAIU.
>>
> 
> Rotary encoder driver handles incremental encoders only and does not
> support absolute encoders. The rotary switch on am335x-ice is different
> from the incremental encoders in the
> sense that GPIO line status directly reflect the position(number)
> pointed by the dial of the encoder. So, there is no need to count steps
> or know the direction of rotation as it does not matter.
> 
> I did try to enhance rotary-encoder driver to support absolute
> encoder[1] but the comment there was to write new driver that simply
> translates gpio-encoded value into ABS* event. Indeed, the new driver
> looks more simple and can handle more such hardwares.

Okay. Yes, that makes sense. Thanks for the explanation!


Daniel
