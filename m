From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 27 Apr 2018 15:58:02 +0100
Subject: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
In-Reply-To: <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
 <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
Message-ID: <dd30b0ed-d958-9bf8-13cf-55d100b645ab@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

On 27/04/18 15:13, Rob Herring wrote:
> On Thu, Apr 26, 2018 at 10:45:46AM +0100, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch add DT bindings for AFE (Audio Frontend) DSP module.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,q6afe.txt       | 88 ++++++++++++++++++++++
>>   include/dt-bindings/sound/qcom,q6afe.h             | 31 ++++++++
>>   2 files changed, 119 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>>   create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>> new file mode 100644
>> index 000000000000..05208a63dd3c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>> @@ -0,0 +1,88 @@
>> +Qualcomm Audio Front End (Q6AFE) binding
>> +
>> +AFE is one of the APR audio service on Q6DSP
>> +Please refer to qcom,apr.txt for details of the common apr service bindings
>> +used by all apr services.
>> +
>> +- but must contain the following property:
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
>> +		  Or "qcom,q6afe" where the version number can be queried
>> +		  from DSP.
>> +		  example "qcom,q6afe"
> 
> reg too.

I did not want to repeat what is already mandated for apr children in 
qcom,apr.txt
So skipped repeating reg property in here.

> 
>> +
>> += AFE DAIs (Digial Audio Interface)
>> +"dais" subnode of the AFE node represents dai specific configuration
>> +
>> +- #sound-dai-cells
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Must be 1
>> +
>> +- reg
> 
> It's not clear here these are in a grandchild node.
> 
Every afe port/dai has some board specifics, to allow that we need dai 
specific child nodes.

>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Must be dai id
>> +
>> +- qcom,sd-lines
>> +	Usage: required for mi2s interface
>> +	Value type: <prop-encoded-array>
>> +	Definition: Must be list of serial data lines used by this dai.
>> +	should be one or more of the 1-4 sd lines.


--srini
