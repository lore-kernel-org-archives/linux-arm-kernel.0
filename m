From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 10 Jun 2013 16:51:41 +0100
Subject: [PATCH v2 04/11] mfd:stixxxx-syscfg: Add ST System Configuration
 support.
In-Reply-To: <2757224.FBxg98dX57@wuerfel>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdaW2ALTWCB7Rd8m=aAGQwh3T_dJVncxJn_eXer4X3J6_g@mail.gmail.com>
 <51B5DA26.6070707@st.com> <2757224.FBxg98dX57@wuerfel>
Message-ID: <51B5F60D.6050205@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the comments.
On 10/06/13 15:02, Arnd Bergmann wrote:
> On Monday 10 June 2013 14:52:38 Srinivas KANDAGATLA wrote:
>> On 10/06/13 14:16, Linus Walleij wrote:
>>> On Mon, Jun 10, 2013 at 11:22 AM, Srinivas KANDAGATLA
>>> <srinivas.kandagatla@st.com> wrote:
>>>
>>>> This mfd driver provides higher level inialization routines for various
>>>> IPs like Ethernet, USB, PCIE, SATA and so on. Also it provides way to
>>>> get to syscfg registers via standard regmap api which is usefull for
>>>> drivers like pinctrl.
>>>>
>>>> This patch adds support to ST System Configuration registers, which can
>>>> be configured by the drivers.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>>> CC: Stuart Menefy <stuart.menefy@st.com>
>>>> CC: Stephen Gallimore <stephen.gallimore@st.com>
>>>> CC: Linus Walleij <linus.walleij@linaro.org>
>>>> CC: Mark Brown <broonie@kernel.org>
>>>
>>> What is this driver doing that drivers/mfd/syscon.c is not already
>>> doing?
>>
>> As of now, the driver is very much similar to syscon + some additional
>> functionality, but we are planning to use this file to add higher level
>> functions to configure different IPs like ethernet, usb, power, reset
>> and so on which are very much specific to ST System Configuration Registers.
> 
> I was expecting that you'd actually interface with the syscon code and
> build on top, rather than copy it.
> 
I did not like the copying either, on the other hand I don't want to
pollute the syscon code.

As you said, I will make use of existing syscon and build "System
configuration interface" on top of it and see how it look like. It will
definitely get rid of lot of code duplication.

Thanks,
srini

> There are multiple ways of doing that, e.g. you could export a function
> from syscon.c that you call to register the device node and then import
> the regmap from syscon into your high-level driver again.

> 
> 	Arnd
> 
> 
