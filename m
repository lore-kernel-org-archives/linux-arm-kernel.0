From: songjun.wu@atmel.com (Wu, Songjun)
Date: Fri, 24 Jun 2016 16:56:49 +0800
Subject: [PATCH v5 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <20160624093501.5dc6d276@bbrezillon>
References: <1466153854-30272-1-git-send-email-songjun.wu@atmel.com>
 <1466153854-30272-3-git-send-email-songjun.wu@atmel.com>
 <20160620132508.GA32585@rob-hp-laptop>
 <850f10c3-ea9a-11da-4279-7b0ad2c52bb6@atmel.com>
 <20160624093501.5dc6d276@bbrezillon>
Message-ID: <03f3bb65-c8c3-e8cc-1311-3a428aff7bc8@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/24/2016 15:35, Boris Brezillon wrote:
> On Fri, 24 Jun 2016 13:54:09 +0800
> "Wu, Songjun" <songjun.wu@atmel.com> wrote:
>
>> Hi Rob,
>>
>> Thank you for your comments.
>>
>> On 6/20/2016 21:25, Rob Herring wrote:
>>> On Fri, Jun 17, 2016 at 04:57:14PM +0800, Songjun Wu wrote:
>>>> DT binding documentation for ISC driver.
>>>>
>>>> Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
>>>> ---
>>>>
>>>> Changes in v5:
>>>> - Add clock names.
>>>>
>>>> Changes in v4:
>>>> - Remove the isc clock nodes.
>>>>
>>>> Changes in v3:
>>>> - Remove the 'atmel,sensor-preferred'.
>>>> - Modify the isc clock node according to the Rob's remarks.
>>>>
>>>> Changes in v2:
>>>> - Remove the unit address of the endpoint.
>>>> - Add the unit address to the clock node.
>>>> - Avoid using underscores in node names.
>>>> - Drop the "0x" in the unit address of the i2c node.
>>>> - Modify the description of 'atmel,sensor-preferred'.
>>>> - Add the description for the ISC internal clock.
>>>>
>>>>  .../devicetree/bindings/media/atmel-isc.txt        | 64 ++++++++++++++++++++++
>>>>  1 file changed, 64 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/media/atmel-isc.txt b/Documentation/devicetree/bindings/media/atmel-isc.txt
>>>> new file mode 100644
>>>> index 0000000..9558a77
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/media/atmel-isc.txt
>>>> @@ -0,0 +1,64 @@
>>>> +Atmel Image Sensor Controller (ISC)
>>>> +----------------------------------------------
>>>> +
>>>> +Required properties for ISC:
>>>> +- compatible
>>>> +	Must be "atmel,sama5d2-isc".
>>>> +- reg
>>>> +	Physical base address and length of the registers set for the device.
>>>> +- interrupts
>>>> +	Should contain IRQ line for the ISC.
>>>> +- clocks
>>>> +	List of clock specifiers, corresponding to entries in
>>>> +	the clock-names property;
>>>> +	Please refer to clock-bindings.txt.
>>>> +- clock-names
>>>> +	Required elements: "hclock".
>>>
>>> What about the 2 other clocks in the example?
>>>
>> The other clocks is optional, not required.
>> Do you have any suggestion?
>
> Just add a second look at the sama5d2 and iscck gck are not optional.
> What we call optional clocks are clocks that are not necessarily
> required depending on the IP revision or external clocks that are board
> dependent. This is not the case here: iscck and gck are internal to the
> SoC, and are always available. Whether you want to use them or not is a
> different question, and should not be encoded in the clocks/clock-names
> properties.
>
> To sum-up, define those 3 clocks as required and document their names.
>
Thank you for your suggestion.
