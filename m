From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 28 Nov 2016 11:25:26 +0100
Subject: [RFC PATCH 3/3] dt-bindings: display: add Amlogic Meson DRM
 Bindings
In-Reply-To: <1695441.JP1H7VIm1f@avalon>
References: <1480089791-12517-1-git-send-email-narmstrong@baylibre.com>
 <2350540.yAeGFdYPK2@avalon>
 <534f6d99-a579-27b6-fb54-48584cd1c7aa@baylibre.com>
 <1695441.JP1H7VIm1f@avalon>
Message-ID: <ee5c5ecf-ef2a-864a-9c2a-1a1d64d857bb@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2016 11:02 AM, Laurent Pinchart wrote:
> Hi Neil,
> 
> On Monday 28 Nov 2016 10:56:30 Neil Armstrong wrote:
>> On 11/28/2016 10:37 AM, Laurent Pinchart wrote:
>>> On Monday 28 Nov 2016 10:23:43 Neil Armstrong wrote:
>>>> On 11/28/2016 09:33 AM, Laurent Pinchart wrote:
>>>>> On Friday 25 Nov 2016 17:03:11 Neil Armstrong wrote:
>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>> ---
>>>>>>
>>>>>>  .../bindings/display/meson/meson-drm.txt           | 134
>>>>>>  +++++++++++++++
>>>>>>  1 file changed, 134 insertions(+)
>>>>>>  create mode 100644
>>>>>>
>>>>>> Documentation/devicetree/bindings/display/meson/meson-drm.txt
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/display/meson/meson-drm.txt
>>>>>> b/Documentation/devicetree/bindings/display/meson/meson-drm.txt new
>>>>>> file
>>>>>> mode 100644
>>>>>> index 0000000..89c1b5f
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/display/meson/meson-drm.txt
>>
>> [...]
>>
>>>>>> +
>>>>>> +VENC CBVS Output
>>>>>> +----------------------
>>>>>> +
>>>>>> +The VENC can output Composite/CVBS output via a decicated VDAC.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +  - compatible: value must be one of:
>>>>>> + - compatible: value should be different for each SoC family as :
>>>>> One of those two lines is redundant.
>>>>
>>>> Will fix.
>>>>
>>>>>> + 	- GXBB (S905) : "amlogic,meson-gxbb-venc-cvbs"
>>>>>> + 	- GXL (S905X, S905D) : "amlogic,meson-gxl-venc-cvbs"
>>>>>> + 	- GXM (S912) : "amlogic,meson-gxm-venc-cvbs"
>>>>>> +	followed by the common "amlogic,meson-gx-venc-cvbs"
>>>>>> +
>>>>>
>>>>> No registers ? Are the encoders registers part of the VPU register
>>>>> space, intertwined in a way that they can't be specified separately here
>>>>> ?
>>>>
>>>> Exact, all the video registers on the Amlogic SoC are part of a long
>>>> history of fixup/enhance from very old SoCs, it's quite hard to
>>>> distinguish a Venc registers array since they are mixed with the
>>>> multiple encoders registers...
>>>
>>> In that case is there really a reason to model the encoders as separate
>>> nodes in DT ?
>>
>> Here, it more the encoder-connector couple that is represented as a node,
>> and the CVBS output is optional.
> 
> You should actually have a DT node for the connector. I would merge the 
> encoders into the VPU node (especially given that according to your diagram 
> they are part of the VPU), and document the VPU output ports explicitly. If 
> the CVBS output is not implemented by some of the SoCs in the family then the 
> corresponding DT node should just omit that port.
> 

Yes, seems a way better option !

[...]


Thanks for the hints,

Neil
