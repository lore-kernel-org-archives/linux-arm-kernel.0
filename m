From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 23 Jan 2017 19:36:08 +0100
Subject: [PATCH 01/18] Documentation: devicetree: amlogic: Reorder boards
In-Reply-To: <20170123164831.ux2kkofq7xf2whnp@rob-hp-laptop>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-2-afaerber@suse.de>
 <20170123164831.ux2kkofq7xf2whnp@rob-hp-laptop>
Message-ID: <31ca7ebb-6101-891f-e8c4-298635d1979e@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.01.2017 um 17:48 schrieb Rob Herring:
> On Fri, Jan 20, 2017 at 11:21:01PM +0100, Andreas F?rber wrote:
>> Enforce groupment by SoCs and order alphabetically within the group
>> (with some exceptions). This should facilitate adding new boards.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  Documentation/devicetree/bindings/arm/amlogic.txt | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
>> index c246cd2730d9..b03d23c9ea78 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
>> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
>> @@ -29,23 +29,30 @@ Boards with the Amlogic Meson GXM S912 SoC shall have the following properties:
>>    Required root node property:
>>      compatible: "amlogic,s912", "amlogic,meson-gxm";
>>  
>> -Board compatible values:
>> +Board compatible values (grouped by SoC):
> 
> ...and alphabetical order within each SoC.

...except for pro, meta, telos, which are in increasing feature set
order - should we reorder them, or ignore but still write alphabetical?

Regards,
Andreas

> 
>> +
>>    - "geniatech,atv1200" (Meson6)
>> +
>>    - "minix,neo-x8" (Meson8)
>> -  - "tronfy,mxq" (Meson8b)
>> +
>>    - "hardkernel,odroid-c1" (Meson8b)
>> +  - "tronfy,mxq" (Meson8b)
>> +
>> +  - "amlogic,p200" (Meson gxbb)
>> +  - "amlogic,p201" (Meson gxbb)
>> +  - "hardkernel,odroid-c2" (Meson gxbb)
>> +  - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
>>    - "tronsmart,vega-s95-pro", "tronsmart,vega-s95" (Meson gxbb)
>>    - "tronsmart,vega-s95-meta", "tronsmart,vega-s95" (Meson gxbb)
>>    - "tronsmart,vega-s95-telos", "tronsmart,vega-s95" (Meson gxbb)
>> -  - "hardkernel,odroid-c2" (Meson gxbb)
>> -  - "amlogic,p200" (Meson gxbb)
>> -  - "amlogic,p201" (Meson gxbb)
>>    - "wetek,hub" (Meson gxbb)
>>    - "wetek,play2" (Meson gxbb)
>> +
>>    - "amlogic,p212" (Meson gxl s905x)
>> +
>>    - "amlogic,p230" (Meson gxl s905d)
>>    - "amlogic,p231" (Meson gxl s905d)
>> +
>>    - "amlogic,q200" (Meson gxm s912)
>>    - "amlogic,q201" (Meson gxm s912)
>> -  - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
>>    - "nexbox,a1" (Meson gxm s912)
>> -- 
>> 2.10.2
>>


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
