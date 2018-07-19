From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 19 Jul 2018 22:27:55 +0800
Subject: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
In-Reply-To: <7h601be2vk.fsf@baylibre.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com> <7hfu0jmhbe.fsf@baylibre.com>
 <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com>
 <7h601be2vk.fsf@baylibre.com>
Message-ID: <e1f0b672-65de-6afa-cec4-e2d910c58b7c@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2018 10:06 PM, Kevin Hilman wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
> 
> [...]
> 
>>>
>>> As Jerome said, I think consistency is an important goal, so leaving off
>>> the "meson-" for drivers/clk is fine with me.
>>>
>> ok
>>
>>> Also for consistency, for the rest of the drivers, keeping "meson-" is
>>> probably the right thing to do.
>>>
>> ok, for the above, you are talking about the already exist compatible
>> names? or the patches we will push in the future?
> 
> I'm talking about future patches.
> 
ok

>>> However, patches would be welcome to add compatibles without the "meson"
>>> for the rest of the drivers & documentation as well, but please do not
>>> remove any compatibles.
>>>
>> I assume you are talking about the patches in the future we will push?
>> to drop the "meson".
>>
>> I'm confused here, as the above two paragraphs conflict with each other
> 
> Yeah, what I wrote is confusing, sorry about that.
> 
> What I mean is that new patches should stay consistent with compatibles
> in their existing drivers/subsystems.  That means keeping the "meson-"
> prefix for everything except drivers/clk.
> 
sounds good to me.

> In addition to that, patches would be welcome for *adding* compatibles
> without "meson" to all the current drivers.
> 
not sure if I parse above correctly, so let me rephrase..

for "all the current drivers", do you mean all the drivers which already
accepted at mainline kernel, which are mmc, uart, spi, i2c ..

all of them follow "amlogic,meson-${SOC}-${FUNCTION}", so do you propose
to add compatbiles like "amlogic,${SOC}-${FUNCTION}" ?

take i2c for example, there is "amlogic,meson-axg-i2c" already, do you
want to add another "amlogic,axg-i2c" ? I feel this will adding more
confusion..

How about only following the "amlogic,${SOC}-${FUNCTION}" syntax in the
new added drivers in the future, for example NAND, PCIE driver which we
want to push (those drivers doesn't exist in current mainline kernel).


Yixun
