From: vigneshr@ti.com (Vignesh R)
Date: Wed, 24 Aug 2016 14:45:17 +0530
Subject: [PATCH v3 0/2] AM335x-ICE: Add support for rotary switch
In-Reply-To: <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
References: <20160824075859.30979-1-vigneshr@ti.com>
 <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
Message-ID: <5294e820-4946-a196-549f-76a349b6606d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 24 August 2016 02:05 PM, Daniel Mack wrote:
> Hi,
> 
> On 08/24/2016 09:58 AM, Vignesh R wrote:
>> This series adds support for rotary-switch on AM335x-ICE that is
>> connected to TI PCA9536 I2C GPIO expander.
>> First patch adds new generic driver to read status of group of GPIO
>> lines and report the value as an input event. The second patch adds DT
>> entries for the same.
>>
>> v2: https://lkml.org/lkml/2016/8/23/111
>> v1: https://lkml.org/lkml/2016/8/12/7
> 
> Is there a reason why the rotary-encoder driver cannot handle this?
> Commit 7dde4e74744 ("Input: rotary-encoder - support more than 2 gpios
> as input") added support for that mode AFAIU.
> 

Rotary encoder driver handles incremental encoders only and does not
support absolute encoders. The rotary switch on am335x-ice is different
from the incremental encoders in the
sense that GPIO line status directly reflect the position(number)
pointed by the dial of the encoder. So, there is no need to count steps
or know the direction of rotation as it does not matter.

I did try to enhance rotary-encoder driver to support absolute
encoder[1] but the comment there was to write new driver that simply
translates gpio-encoded value into ABS* event. Indeed, the new driver
looks more simple and can handle more such hardwares.

[1] https://lkml.org/lkml/2016/5/19/98


-- 
Regards
Vignesh
