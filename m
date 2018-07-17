From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 17 Jul 2018 09:24:02 +0800
Subject: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
In-Reply-To: <7hfu0jmhbe.fsf@baylibre.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com> <7hfu0jmhbe.fsf@baylibre.com>
Message-ID: <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Kevin

just want to clarify..

On 07/16/18 21:38, Kevin Hilman wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
> 
>> On Tue, 2018-07-10 at 09:21 +0800, Yixun Lan wrote:
>>>
>>> On 07/10/18 05:53, Martin Blumenstingl wrote:
>>>> On Mon, Jul 9, 2018 at 1:14 PM Jian Hu <jian.hu@amlogic.com> wrote:
> 
> [...]
> 
>>>>> +
>>>>> +static const struct of_device_id clkc_match_table[] = {
>>>>> +       { .compatible = "amlogic,g12a-clkc" },
>>>>
>>>> I wonder if that should be "amlogic,meson-g12a-clkc" (I know that AXG
>>>> and GXBB/GXL/GXM omit the "meson-" prefix, but I am not sure if that's
>>>> correct - I'll CC Rob Herring on the dt-bindings patch)
>>>>
>>>
>>> we're fine with either way, since the g12a is recently new added SoC.
>>>
>>> but I guess those old compatibles which already exist won't be changed,
>>> as it will break the DT
>>
>> Yes, I doubt we are going to change the compatibles. With or without the meson
>> prefix, I suppose it going to stay that way.
> 
> Correct, we will not change existing compatibles.  Adding new ones for
> clarity is fine though.
> 
fine

>> It is worth thinking about it for new drivers though.
>> We already have the "amlogic,", so do we really to prefix even more with "meson-
>> "
>>
>> Also, if we were really strict about that scheme, should meson8b compatible be
>>
>> "amlogic,meson-meson8b-foo-bar" ... the SoC is meson8b, not just 8b after all ?
>>
>> For the particular case of the clock controller, I don't care very much, as long
>> as the compatible is coherent with documentation.
>>
>> I might have a preference for the current compatible ... just for consistency
>> with the other clock controllers.
> 
> In hindsight, I think using the "meson" prefix was a mistake.  It's
> redunant, IMO, but it's how we've been doing things for all the drivers,
> except for drivers/clk, which, honestly, I hadn't even noticed until
> now.
> 
> As Jerome said, I think consistency is an important goal, so leaving off
> the "meson-" for drivers/clk is fine with me.
> 
ok

> Also for consistency, for the rest of the drivers, keeping "meson-" is
> probably the right thing to do.
> 
ok, for the above, you are talking about the already exist compatible
names? or the patches we will push in the future?

> However, patches would be welcome to add compatibles without the "meson"
> for the rest of the drivers & documentation as well, but please do not
> remove any compatibles.
> 
I assume you are talking about the patches in the future we will push?
to drop the "meson".

I'm confused here, as the above two paragraphs conflict with each other

> Kevin
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> .
> 
