From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 24 Apr 2018 17:49:15 +0100
Subject: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
In-Reply-To: <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
Message-ID: <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

On 24/04/18 17:25, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:55PM +0100, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,apq8096.txt     | 76 ++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>> new file mode 100644
>> index 000000000000..37e23d926b95
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>> @@ -0,0 +1,76 @@
>> +* Qualcomm Technologies APQ8096 ASoC sound card driver
>> +
>> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,apq8096-sndcard"
>> +
>> +- qcom,audio-routing:
>> +	Usage: Optional
>> +	Value type: <stringlist>
>> +	Definition:  A list of the connections between audio components.
>> +		  Each entry is a pair of strings, the first being the
>> +		  connection's sink, the second being the connection's
>> +		  source. Valid names could be power supplies, MicBias
>> +		  of codec and the jacks on the board:
> 
> Please list out valid values here.

I can list the values for the HDMI playback use-case, but the list would 
grow as we start adding wcd9335 codec support.

> 
>> +
>> += dailinks
>> +Each subnode of sndcard represents either a dailink, and subnodes of each
>> +dailinks would be cpu/codec/platform dais.
>> +
>> +- link-name:
> 
> Not a standard property, but I guess that sneaked in with the 8016
> binding...
Yes, I followed 8016 bindings.

Am happy to prefix this with qcom if that makes more sense.
> 
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: User friendly name for dai link
>> +
>> += CPU, PLATFORM, CODEC dais subnodes
>> +- cpu:
>> +	Usage: required
>> +	Value type: <subnode>
>> +	Definition: cpu dai sub-node
>> +
>> +- codec:
>> +	Usage: Optional
>> +	Value type: <subnode>
>> +	Definition: codec dai sub-node
>> +
>> +- platform:
>> +	Usage: Optional
>> +	Value type: <subnode>
>> +	Definition: platform dai sub-node
>> +
>> +- sound-dai:
>> +	Usage: required
>> +	Value type: <phandle>
> 
> phandle with args.
Yep.

--srini
