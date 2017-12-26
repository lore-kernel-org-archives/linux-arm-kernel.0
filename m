From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Dec 2017 16:09:24 -0200
Subject: [PATCH] ARM: dts: imx: Add memory node unit name
In-Reply-To: <CAM4PwSVzVn3=wWpFohw2q23Oiwp1FimCkdHPq=BfG-QzuuPtfQ@mail.gmail.com>
References: <1512575989-15627-1-git-send-email-marcofrk@gmail.com>
 <20171221090736.3ac9d5db@karo-electronics.de>
 <CAM4PwSVzVn3=wWpFohw2q23Oiwp1FimCkdHPq=BfG-QzuuPtfQ@mail.gmail.com>
Message-ID: <CAOMZO5But4BU0WP69LoCgGqPGDFNw8hsBB+P8=416oB1e1q6tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Dec 21, 2017 at 12:26 PM, Marco Franchi <marcofrk@gmail.com> wrote:
> Hi Lothar,
>
> 2017-12-21 6:07 GMT-02:00 Lothar Wa?mann <LW@karo-electronics.de>:
>> Hi,
>>
>> On Wed,  6 Dec 2017 13:59:49 -0200 Marco Franchi wrote:
>>> Fix the following warnings from dtc by adding the unit name to memory
>>> nodes:
>>>
>>> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>>>
>>> Converted using the following command:
>>>
>>> perl -p0777i -e 's/memory \{\n\t\treg = \<0x+([0-9a-f])/memory\@$1$\0000000 \{\n\t\treg = <0x$1/m' `find ./arch/arm/boot/dts -name "imx*"`
>>>
>>> The files below were manually fixed:
>>> -imx1-ads.dts
>>> -imx1-apf9328.dts
>>>
>> The imx*.dtsi files all have this:
>> |       memory { device_type = "memory"; reg = <0 0>; };
>> Thus you will end up with a 'memory' node with a reg = <0 0> entry and
>> an additional 'memory at ...' node with the correct 'reg' values.
>
> You are right. The .dtb files were composed by two different memory nodes.
> Do you have some recommendation to take off this specific warning?

Currently the only dtc warnings we have with imx_v6_v7_defconfig are:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges
property, but no unit name

What is the recommended way to fix these warnings?

Thanks
