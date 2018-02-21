From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Feb 2018 08:51:48 -0800
Subject: [PATCH v4 2/4] dt-bindings: qcom: Add SDM845 bindings
In-Reply-To: <20180219193426.darxcui4g4oxyf32@rob-hp-laptop>
References: <20180216060503.22006-1-rnayak@codeaurora.org>
 <20180216060503.22006-3-rnayak@codeaurora.org>
 <20180219193426.darxcui4g4oxyf32@rob-hp-laptop>
Message-ID: <CAD=FV=UWUD4VMN4gLxBLsSEnsTnOot+ydsaOiFqvD-B2e_RQAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Mon, Feb 19, 2018 at 11:34 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Feb 16, 2018 at 11:35:01AM +0530, Rajendra Nayak wrote:
>> Add a SoC string 'sdm845' for the qualcomm SDM845 SoC
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
>> index 0ed4d39d7fe1..ee532e705d6c 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.txt
>> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
>> @@ -26,6 +26,7 @@ The 'SoC' element must be one of the following strings:
>>       msm8996
>>       mdm9615
>>       ipq8074
>> +     sdm845
>
> These should really be the full string with 'qcom,', but you don't have
> to fix that now.
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review!  I agree that we should land this and then make
further progress in additional patches.


Are you suggesting to rewriting this whole bindings doc to not specify
things in an "M x N" type of way?  AKA the top of this doc says:

> Each board must specify a top-level board compatible string with the following
> format:
>         compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
> The 'SoC' and 'board' elements are required. All other elements are optional.

...and then the doc goes on to give lists of known SoC and board values.


Presumably if someone were to fix this then they'd need to try to
track down existing boards so they could enumerate every known
combination?


-Doug
