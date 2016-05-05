From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 5 May 2016 18:16:11 -0500
Subject: [Patch v3 1/8] dt/bindings: firmware: Add Qualcomm SCM binding
In-Reply-To: <20160505221713.GA12273@rob-hp-laptop>
References: <1462402245-18295-1-git-send-email-andy.gross@linaro.org>
 <1462402245-18295-2-git-send-email-andy.gross@linaro.org>
 <20160505221713.GA12273@rob-hp-laptop>
Message-ID: <CAPBZ5QfYOiGniV6PGRRRgAb2sy=J2TjVSxM-+42GR+4mU-Ht9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2016 at 17:17, Rob Herring <robh@kernel.org> wrote:
> On Wed, May 04, 2016 at 05:50:38PM -0500, Andy Gross wrote:
>> This patch adds the device tree support for the Qualcomm SCM firmware.
>>
>> Signed-off-by: Andy Gross <andy.gross@linaro.org>
>> ---
>>  .../devicetree/bindings/firmware/qcom,scm.txt      | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
>> new file mode 100644
>> index 0000000..ee7cd12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
>> @@ -0,0 +1,26 @@
>> +QCOM Secure Channel Manager (SCM)
>> +
>> +Qualcomm processors include an interface to communicate to the secure firmware.
>> +This interface allows for clients to request different types of actions.  These
>> +can include CPU power up/down, HDCP requests, loading of firmware, and other
>> +assorted actions.
>> +
>> +Required properties:
>> +- compatible: must contain one of the following:
>> + * "qcom,scm-a-family" for A family Qualcomm processors (APQ8064, MSM8960, etc)
>> + * "qcom,scm" for B family and later processors (MSM8916, APQ8084, MSM8974, etc)
>> +- clocks: One to three clocks may be required based on compatible.
>> + * Only core clock required for "qcom,scm-apq8064"
>
> This is not a compatible string. What happened to the chip ones. I
> thought we decided on chip specific plus one of the above ones.

Stephen specifically didn't like the chip ones due to churn.  We'd
have to add compat tags every time we got a new chip.... which is kind
of frequent.  So I opted for defining one compat for older A family
chips that require only 1 clock.  The qcom,scm would cover the newer
chips.

And it looks like i left a reference to apq8064.  That needs to be
replaced with a-family.  Sorry for that confusion.

Regards,

Andy
