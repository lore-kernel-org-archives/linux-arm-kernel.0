From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 31 Oct 2016 10:28:26 -0500
Subject: [PATCHv2 1/4] dt-bindings: mfd: Add Altera Arria10 SR Monitor
In-Reply-To: <20161031053604.3rjbuk7maabzbwq7@rob-hp-laptop>
References: <1477598426-28125-1-git-send-email-tthayer@opensource.altera.com>
 <1477598426-28125-2-git-send-email-tthayer@opensource.altera.com>
 <20161031053604.3rjbuk7maabzbwq7@rob-hp-laptop>
Message-ID: <895cf1ec-929a-8c41-c74a-948efcb89222@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 10/31/2016 12:36 AM, Rob Herring wrote:
> On Thu, Oct 27, 2016 at 03:00:23PM -0500, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Add the Arria10 DevKit System Resource Chip register and state
>> monitoring module to the MFD.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> Note: This needs to be applied to the bindings document that
>> was Acked & Applied but didn't reach the for-next branch.
>> See https://patchwork.ozlabs.org/patch/629397/
>> ---
>> v2  Change compatible string -mon to -monitor for clarity
>> ---
>>  Documentation/devicetree/bindings/mfd/altera-a10sr.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
>> index ea151f2..c47be28 100644
>> --- a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
>> +++ b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
>> @@ -18,6 +18,7 @@ The A10SR consists of these sub-devices:
>>  Device                   Description
>>  ------                   ----------
>>  a10sr_gpio               GPIO Controller
>
> This should be just "gpio" BTW.

I reason I preprend a10sr_ is to distinguish this GPIO from the other 
GPIOs when binding to our LEDs (see below). I think the LEDs need a 
unique node name (unless I'm not understanding something).

A less important reason I use a10sr_gpio on the node name is that I can 
cat the /sys/class/gpio/gpioxxx/label and see that it is associated with 
the a10sr instead of one of our other general GPIOs. Is there a better 
way to distinguish these?

>
>> +a10sr_monitor            Register and State Monitoring
>
> s/_/-/ or maybe just "monitor". Not really a generic node name to use
> for this.
>

The reason I use _ for the node name is that the DTC fails if I 
reference a node name with "-" but works OK for "_". For instance, I get 
an error if the LEDs reference "a10sr-gpio" but "a10sr_gpio" compiles ok.

Thanks for reviewing!

Thor

> Rob
>
