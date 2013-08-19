From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 16:52:33 -0600
Subject: [PATCH v4 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <1798078.kJ4bQYzcF9@flatron>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-2-git-send-email-markus.mayer@linaro.org>
 <1798078.kJ4bQYzcF9@flatron>
Message-ID: <5212A1B1.2030203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 04:47 PM, Tomasz Figa wrote:
> Hi Markus,
> 
> Please see my comments inline.
> 
> On Monday 19 of August 2013 11:59:19 Markus Mayer wrote:
>> This patch adds the GPIO driver for the bcm281xx family of chips.

>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt

>> +- interrupts: The interrupt outputs from the controller. There is one
>> GPIO +  interrupt per GPIO bank. The number of GPIO banks is HW
>> configurable.
> 
> What do you mean by HW configurable? Does it mean that it depends from
> SoC or you can have different bank configurations on the same SoC?

the wording is a little odd; I was going to comment on it, but thought
it was probably clear enough.

> How does the driver know the layout of GPIO banks? The code suggests that
> the number of interrupts is used as bank count. While this saves you from
> adding any new property or any other way of getting this information, I'm
> not sure if it's completely correct. I'd like to hear others' opinion on
> this, though.

I expect a lookup table with key being the exact compatible value, and
output being the # banks would be a reasonable driver implementation.
Keying off the number of entries in interrupts seems fine too, since it
should work out OK (Tegra does this IIRC).
