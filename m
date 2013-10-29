From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 29 Oct 2013 10:49:35 -0500
Subject: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <526FB5FF.2060908@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
 <40E3A029-C7E8-41DA-9218-3FB7ED97B707@codeaurora.org>
 <526FB5FF.2060908@st.com>
Message-ID: <BA9BDFB3-122B-4BE4-BD89-2B30D5450FF6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 29, 2013, at 8:19 AM, Maxime Coquelin wrote:

> 
> On 10/28/2013 08:25 PM, Kumar Gala wrote:
>> On Oct 14, 2013, at 7:46 AM, Maxime COQUELIN wrote:
>> 
>>> This patch adds support to SSC (Synchronous Serial Controller)
>>> I2C driver. This IP also supports SPI protocol, but this is not
>>> the aim of this driver.
>>> 
>>> This IP is embedded in all ST SoCs for Set-top box platorms, and
>>> supports I2C Standard and Fast modes.
>>> 
>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>>> ---
>>> Documentation/devicetree/bindings/i2c/i2c-st.txt |   38 +
>>> drivers/i2c/busses/Kconfig                       |   10 +
>>> drivers/i2c/busses/Makefile                      |    1 +
>>> drivers/i2c/busses/i2c-st.c                      |  867 ++++++++++++++++++++++
>>> 4 files changed, 916 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/i2c/i2c-st.txt
>>> create mode 100644 drivers/i2c/busses/i2c-st.c
>>> 
>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-st.txt b/Documentation/devicetree/bindings/i2c/i2c-st.txt
>>> new file mode 100644
>>> index 0000000..8b2fd0b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-st.txt
>>> @@ -0,0 +1,38 @@
>>> +ST SSC binding, for I2C mode operation
>>> +
>>> +Required properties :
>>> +- compatible : Must be "st,comms-i2c"
>>> +- reg : Offset and length of the register set for the device
>>> +- interrupts : the interrupt specifier
>>> +- clock-names: Must contain "ssc".
>>> +- clocks: Must contain an entry for each name in clock-names. See the common
>>> +  clock bindings.
>>> +- A pinctrl state named "default" must be defined, using the bindings in
>>> +  ../pinctrl/pinctrl-binding.txt
>>> +
>>> +Optional properties :
>>> +- clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
>>> +  the default 100 kHz frequency will be used. As only Normal and Fast modes
>>> +  are supported, possible values are 100000 and 400000.
>>> +- i2c-min-scl-pulse-width-us : The minimum valid SCL pulse width that is
>>> +  allowed through the deglitch circuit. In units of us.
>>> +- i2c-min-sda-pulse-width-us : The minimum valid SDA pulse width that is
>>> +  allowed through the deglitch circuit. In units of us.
>> i2c-min... should be vendor prefixed, st,i2c-min...
> This was already discussed in earlier revisions of the patches.
> Initially this was prefixed with "st,", but Wolfram asked to put these properties as generic.
> As explained in the cover letter, there are no I2C DT binding documentation for now, but it is in Wolfram's ToDo list.
> As soon as Wolfram has created the documentation, I will create a patch to document
> 
> i2c-min-scl-pulse-width-us and i2c-min-sda-pulse-width-us there.

Missed that, would be good to maybe comment about that in the commit message.. Or is there some reason to not just put them into a i2c/i2c-bus.txt right now?

>>> 
>>> +- A pinctrl state named "sleep" could be defined, using the bindings in
>>> +  ../pinctrl/pinctrl-binding.txt
>> I don't see any reference to "sleep" in pinctrl-binding.txt
> Right, I will correct that.
> 
> Thanks for the review,
> Maxime

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
