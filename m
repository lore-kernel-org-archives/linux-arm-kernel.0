From: elder@linaro.org (Alex Elder)
Date: Fri, 9 Nov 2018 16:38:30 -0600
Subject: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
In-Reply-To: <CAK8P3a1rXwADsgVJ4EAtV3u_qg840tfGnbKcyxuBXDB10sYi3Q@mail.gmail.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-2-elder@linaro.org>
 <CAK8P3a1rXwADsgVJ4EAtV3u_qg840tfGnbKcyxuBXDB10sYi3Q@mail.gmail.com>
Message-ID: <d5c89037-f4fa-6ab7-dbca-d63f64c90fdc@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/18 5:50 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>>
>> Add the binding definitions for the "qcom,ipa" and "qcom,rmnet-ipa"
>> device tree nodes.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>  .../devicetree/bindings/soc/qcom/qcom,ipa.txt | 136 ++++++++++++++++++
>>  .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |  15 ++
>>  2 files changed, 151 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
> 
> I think this should go into bindings/net instead of bindings/soc, since it's
> mostly about networking rather than a specific detail of managing the SoC
> itself.

Done (in my tree--and will be reflected next time I send something out).

>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>> new file mode 100644
>> index 000000000000..d4d3d37df029
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>> @@ -0,0 +1,136 @@
>> +Qualcomm IPA (IP Accelerator) Driver
>> +
>> +This binding describes the Qualcomm IPA.  The IPA is capable of offloading
>> +certain network processing tasks (e.g. filtering, routing, and NAT) from
>> +the main processor.  The IPA currently serves only as a network interface,
>> +providing access to an LTE network available via a modem.
> 
> That doesn't belong into the binding. Say what the hardware can do here,
> not what a specific implementation of the driver does at this moment.
> The binding should be written in an OS independent way after all.

OK.

>> +- interrupts-extended:
>> +       Specifies the IRQs used by the IPA.  Four cells are required,
>> +       specifying: the IPA IRQ; the GSI IRQ; the clock query interrupt
>> +       from the modem; and the "ready for stage 2 initialization"
>> +       interrupt from the modem.  The first two are hardware IRQs; the
>> +       third and fourth are SMP2P input interrupts.
> 
> You mean 'four interrupts', not 'four cells' -- each interrupt specifier
> already consists of at least two cells (one for the phandle to the
> irqchip, plus one or more cells to describe that interrupt).

OK.

>> +- interconnects:
>> +       Specifies the interconnects used by the IPA.  Three cells are
>> +       required, specifying:  the path from the IPA to memory; from
>> +       IPA to internal (SoC resident) memory; and between the AP
>> +       subsystem and IPA for register access.
> 
> Same here and in the rest.

OK, I've fixed all of these.  Thank you.

					-Alex

> 
>       Arnd
> 
