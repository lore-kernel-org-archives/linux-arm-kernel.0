From: fcooper@ti.com (Franklin S Cooper Jr.)
Date: Thu, 28 Apr 2016 16:41:31 -0500
Subject: [PATCH v7 4/9] pwm: pwm-tiecap: Update dt binding document to use
 proper unit address
In-Reply-To: <20160428213122.GA27352@rob-hp-laptop>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
 <1461710209-6563-5-git-send-email-fcooper@ti.com>
 <20160428213122.GA27352@rob-hp-laptop>
Message-ID: <5722838B.7070309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/28/2016 04:31 PM, Rob Herring wrote:
> On Tue, Apr 26, 2016 at 05:36:44PM -0500, Franklin S Cooper Jr wrote:
>> Replace unit address from 0 to the proper physical address.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
>> index 788da6c..1b7eec5 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
>> @@ -16,21 +16,21 @@ Optional properties:
>>  
>>  Example:
>>  
>> -ecap0: ecap at 0 { /* ECAP on am33xx */
>> +ecap0: ecap at 48300100 { /* ECAP on am33xx */
>>  	compatible = "ti,am33xx-ecap";
>>  	#pwm-cells = <3>;
>>  	reg = <0x48300100 0x80>;
>>  	ti,hwmods = "ecap0";
>>  };
>>  
>> -ecap0: ecap at 0 { /* ECAP on am4372 */
>> +ecap0: ecap at 48300100 { /* ECAP on am4372 */
>>  	compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
>>  	#pwm-cells = <3>;
>>  	reg = <0x48300100 0x80>;
>>  	ti,hwmods = "ecap0";
>>  };
>>  
>> -ecap0: ecap at 0 { /* ECAP on da850 */
>> +ecap0: ecap at 1f06000 { /* ECAP on da850 */
>>  	compatible = "ti,da850-ecap", "ti,am33xx-ecap";
>>  	#pwm-cells = <3>;
>>  	reg = <0x306000 0x80>;
> 
> These still don't match.
> 
> Rob


I apologize you made a similar comment in the past but I misinterpreted
it recently which is why I made the same mistake again. I'll fix it.

Any issue with my response to your patch two comment for why I did
things the way I did? If so I can fix it when I send my new rev.

> 
>> -- 
>> 2.7.0
>>
