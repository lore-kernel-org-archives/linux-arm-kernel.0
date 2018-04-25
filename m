From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Apr 2018 10:04:54 -0500
Subject: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
In-Reply-To: <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
 <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
Message-ID: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 11:49 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Thanks for the review.
>
>
> On 24/04/18 17:25, Rob Herring wrote:
>>
>> On Wed, Apr 18, 2018 at 04:31:55PM +0100, srinivas.kandagatla at linaro.org
>> wrote:
>>>
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>
>>> Add devicetree bindings documentation file for Qualcomm apq8096 sound
>>> card.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   .../devicetree/bindings/sound/qcom,apq8096.txt     | 76
>>> ++++++++++++++++++++++
>>>   1 file changed, 76 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>> b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>> new file mode 100644
>>> index 000000000000..37e23d926b95
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>> @@ -0,0 +1,76 @@
>>> +* Qualcomm Technologies APQ8096 ASoC sound card driver
>>> +
>>> +This binding describes the APQ8096 sound card, which uses qdsp for
>>> audio.
>>> +
>>> +- compatible:
>>> +       Usage: required
>>> +       Value type: <stringlist>
>>> +       Definition: must be "qcom,apq8096-sndcard"
>>> +
>>> +- qcom,audio-routing:
>>> +       Usage: Optional
>>> +       Value type: <stringlist>
>>> +       Definition:  A list of the connections between audio components.
>>> +                 Each entry is a pair of strings, the first being the
>>> +                 connection's sink, the second being the connection's
>>> +                 source. Valid names could be power supplies, MicBias
>>> +                 of codec and the jacks on the board:
>>
>>
>> Please list out valid values here.
>
>
> I can list the values for the HDMI playback use-case, but the list would
> grow as we start adding wcd9335 codec support.

If you don't have the values, then how does one validate a DT is correct?

Honestly, a single property like this seems insufficient to describe
audio routing.

>>> +
>>> += dailinks
>>> +Each subnode of sndcard represents either a dailink, and subnodes of
>>> each
>>> +dailinks would be cpu/codec/platform dais.
>>> +
>>> +- link-name:
>>
>>
>> Not a standard property, but I guess that sneaked in with the 8016
>> binding...
>
> Yes, I followed 8016 bindings.
>
> Am happy to prefix this with qcom if that makes more sense.

I'd just leave it to be consistent.
