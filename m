From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 27 Apr 2018 20:16:57 +0100
Subject: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
In-Reply-To: <CAL_JsqLLqr87F53rbR+DU9Qj9=9SWWrw45TWZaG6f_gnYfPNgw@mail.gmail.com>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
 <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
 <dd30b0ed-d958-9bf8-13cf-55d100b645ab@linaro.org>
 <CAL_JsqLLqr87F53rbR+DU9Qj9=9SWWrw45TWZaG6f_gnYfPNgw@mail.gmail.com>
Message-ID: <16204d76-c3f9-a185-6e1d-34d86dc40688@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/04/18 19:32, Rob Herring wrote:
>>>> +
>>>> += AFE DAIs (Digial Audio Interface)
>>>> +"dais" subnode of the AFE node represents dai specific configuration
>>>> +
>>>> +- #sound-dai-cells
>>>> +       Usage: required
>>>> +       Value type: <u32>
>>>> +       Definition: Must be 1
>>>> +
>>>> +- reg
>>>
>>> It's not clear here these are in a grandchild node.
>>>
>> Every afe port/dai has some board specifics, to allow that we need dai
>> specific child nodes.
> Yes, but what I mean is #sound-dai-cells is a property of the dais
> node, but reg and qcom,sd-lines are properties of child nodes under
> the dais node. It is evident in the example, but not without the
> example. >
> Also, anywhere with reg needs #address-cells and #size-cells in the parent node.
>
Yep, #address-cells and #size-cells are missing, Will add them along 
with some notes.

thanks,
srini




> Rob
