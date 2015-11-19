From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 19 Nov 2015 14:43:20 +0000
Subject: [PATCH v9 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <564DD44E.4010804@sigmadesigns.com> (Marc Gonzalez's message of
 "Thu, 19 Nov 2015 14:53:18 +0100")
References: <564C94A5.4060301@sigmadesigns.com>
 <564C94FD.60607@sigmadesigns.com> <yw1xr3jnfg2s.fsf@unicorn.mansr.com>
 <564CA880.1030502@sigmadesigns.com>
 <yw1xmvubfekf.fsf@unicorn.mansr.com>
 <CAOesGMjCw_DYB3OktnQvthqBAQxqeH6F0bXR-KW_36Y9sDh+fg@mail.gmail.com>
 <yw1xio4zfcpc.fsf@unicorn.mansr.com>
 <564DD44E.4010804@sigmadesigns.com>
Message-ID: <yw1x4mgif3sn.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> M?ns Rullg?rd wrote:
>
>> Olof Johansson wrote:
>> 
>>> M?ns Rullg?rd wrote:
>>>
>>>> Marc Gonzalez wrote:
>>>>
>>>>> M?ns Rullg?rd wrote:
>>>>>
>>>>>> Marc Gonzalez wrote:
>>>>>>
>>>>>>> +           clkgen: clkgen at 10000 {
>>>>>>> +                   compatible = "sigma,tango4-clkgen";
>>>>>>> +                   reg = <0x10000 0x40>;
>>>>>>> +                   clocks = <&xtal>;
>>>>>>> +                   clock-output-names = "cpuclk", "sysclk";
>>>>>>> +                   #clock-cells = <1>;
>>>>>>> +           };
>>>>>>
>>>>>> Would you please consider using my clock driver that matches the actual
>>>>>> hardware, supports all the clock outputs required for USB, SATA, etc,
>>>>>> and works on tango3 as well?
>>>>>
>>>>> I was hoping to take baby steps to work up to a fully-functional port.
>>>>> The first step (in my mind) is this submission: a minimal port which
>>>>> only requires the two "main" clocks.
>>>>>
>>>>> The next step will add to the minimal port by supporting as many
>>>>> peripherals as possible, as well as their required clocks.
>>>>
>>>> But the code already exists.  Why start over?
>
> "La perfection est atteinte, non pas lorsqu'il n'y a plus rien ? ajouter,
> mais lorsqu'il n'y a plus rien ? retirer."
>
> For example, what is the point of not ignoring sysclk_premux, when the boot
> loader has always hard-coded "PLL1 drives sys_clk, PLL2 drives cd_clk".

What if the boot loader changes?  Since we know the structure of the
clock tree, it's safer to check how it is actually configured.

> Having one clk driver for tango3, and another for tango4 allows you to
> submit your own tango3 clk driver, and I can then ignore all the insane
> tango3 clk legacy, and focus on the tango4 clean-ups. Would that work
> for you?

That would be a complete waste.

> (BTW, are you aware that the clk maintainers will NAK your clk driver in
> its current form, based on the fact that they insist on a single node
> for the entire clkgen block?)

Yes, I know that.  It's the third or fourth time they've completely
changed the preferred way of doing clocks.

>>> M?ns, I don't understand your role in this. Can you clarify?
>> 
>> Oh, I'm just the guy who did all the work and then got screwed over by
>> Sigma.
>
> Here's the sequence of events, to the best of my recollection.
>
> In 2010, you hacked the Popcorn Hour C-200 (Tango3 SoC)
> In 2014-11, I mentioned on LAKML that I planned to upstream Sigma's kernel
> In 2014-12, you pushed your tango3 port to github (3.18 at the time IIRC)
> 	https://github.com/mansr/linux-tangox
> In late 2015-02, you blogged about your work
> 	http://hardwarebug.org/2015/02/26/popcorn-hour-revisited/
> I contacted you the next day, and you offered your services.
> You met management in late March.
> Then radio silence for several months.
> Sometime in July, I was told the deal had fallen apart :-(

Something like that, yes.  I'd be less upset with them if there hadn't
been promises made only to be followed by lame excuses and stonewalling.

>>> If you've already done a port, why haven't you contributed it
>>> yourself?
>> 
>> Because it's not yet in a shape to be contributed, just like Marc's
>> isn't.
>
> Are you saying the DT needs to be perfect on the first submission?
> Has this been true for other mach?

There's this notion of "DT is ABI" and must be stable.  Changing
existing bindings is strongly frowned upon.

>>> Why are you driving Marc's work from the back seat like this instead
>>> of submitting your own work?
>> 
>> I have submitted bits and pieces.  It's a slow process.
>
> Indeed. Especially when a maintainer NAKs a patch because one used
> 'unsigned' instead of 'unsigned int'.

That I can live with.  It's more frustrating to have at least a day of
turnaround time for each nitpick like that.  Oh well.

At least the serial port support is upstream.  That's a start.

-- 
M?ns Rullg?rd
mans at mansr.com
