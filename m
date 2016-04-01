From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 08:25:10 -0500
Subject: dtc warnings
In-Reply-To: <56FE27F9.2070100@gmail.com>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
 <56FE27F9.2070100@gmail.com>
Message-ID: <CAL_Jsq+wPdkMcCkvMGQMyVdSbc_NfhbPN1PxX2c8EiWd=fpfOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2016 at 2:49 AM, Tomi Valkeinen <tomi.valkeinen@gmail.com> wrote:
> Hi Rob,
>
> On 01/04/16 04:40, Rob Herring wrote:
>> You may have noticed that linux-next had gotten noisy with dtc
>> warnings lately. I dropped the change for a bit, but added it back
>> today except now it is disabled unless building with "W=1".
>>
>> There's ~25K (2500 unique) warnings generated from the ARM dts files.
>> Here's the ranking of warnings by dtb. OMAP is the clear winner (based
>> on the similar counts, probably lots of duplicates). Please help
>> remind contributors to test with W=1 and start to fix these.
>>
>> At least for memory nodes, I plan to whitelist allowing no
>> unit-address. There could be others, but none that I've seen so far.
>
> What's the correct way to fix nodes for display platform devices? For
> example, omap4-panda-common.dtsi has two connector nodes:
>
> dvi0: connector at 0 {
>         compatible = "dvi-connector";
>         label = "dvi";
>         ...
> };
>
>
> hdmi0: connector at 1 {
>         compatible = "hdmi-connector";
>         label = "hdmi";
>         ...
> };
>
> Should I add the reg property, or should I rename the nodes to, say,
> connector_dvi and connector_hdmi, or connector1 and connector2?

I think adding reg only makes sense if it maps to something addressable by s/w.

So in this case: dvi-connector and hdmi-connector

If we have 2 of the same type, we'll probably have to append a number.

Rob
