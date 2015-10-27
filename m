From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 27 Oct 2015 09:12:17 +0100
Subject: [linux-sunxi] Re: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3
 DTSI
In-Reply-To: <20151026210623.GB10947@lukather>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151023181406.GK10947@lukather> <20151023212013.50bcbe4a@OPI2>
 <20151024071328.GQ10947@lukather> <20151024104749.179dab64@OPI2>
 <20151026210623.GB10947@lukather>
Message-ID: <562F31E1.9070203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26-10-15 22:06, Maxime Ripard wrote:
> On Sat, Oct 24, 2015 at 10:47:49AM +0200, Jean-Francois Moine wrote:
>> On Sat, 24 Oct 2015 09:13:28 +0200
>> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>>
>>> Or simply
>>>
>>> bus_gates {
>>> 	clocks = <&ahb1>, <&ahb2>;
>>> 	clock-indices = <5>, <6>, <8>, ...
>>> 	clock-output-names = "bus_ce", "bus_dma", "bus_mmc0"
>>> };
>>
>> I don't understand: the apb1, apb2, ahb1 and ahb2 clocks may be
>> programmed independently to different frequencies
>
> I don't understand why you're talking about frequencies here.
>
>> and you have to know which of them is the parent of each leaf clock.
>
> Indeed, but that's also doable here. Just not in the DT.
>
>> So, either you hard-code the parents as Jens did in a first proposal,
>> or you define the full list of parents in the DT as in the last
>> proposal, or you use a container per parent in the DT as I proposed.
>>
>> There could be an other solution using the output clock name to define
>> the parent clock:
>>
>> bus_gates {
>> 	clocks = <&ahb1>, <&ahb2>, <&apb1>, <&apb2>;
>> 	clock-indices = <5>, <6>, <8>, ...
>> 	clock-output-names = "ahb1_ce", "ahb1_dma", "ahb1_mmc0"
>> };
>>
>> with the documentation:
>>
>> 	"the clocks MUST be defined in order: ahb1, ahb2, apb1, apb2."
>>
>> and the code
>>
>> 	if (strncmp(clock_name, "ahb1", 4) == 0)
>> 		clk_parent = of_clk_get_parent_name(node, 0);
>> 	else if (..)
>>
>> but it seems a bit hacky.
>
> It's exactly what I suggested, without the string comparison, but
> relying on the ID instead.

I'm not following you here, what do you mean with "the ID" ?

Regards,

Hans
