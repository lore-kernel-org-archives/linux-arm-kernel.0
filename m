From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 11:37:57 +0100
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <87y5otepch.fsf@lebrac.rtp-net.org>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091218.GB6820@lunn.ch> <20120515111757.32847b91@skate>
 <87y5otepch.fsf@lebrac.rtp-net.org>
Message-ID: <4FB23205.809@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 11:00, Arnaud Patard (Rtp) wrote:
> Thomas Petazzoni<thomas.petazzoni@free-electrons.com>  writes:
>
> Hi,
>> Hello Andrew,
>>
>> Thanks for the quick feedback!
>>
>> Le Tue, 15 May 2012 11:12:18 +0200,
>> Andrew Lunn<andrew@lunn.ch>  a ?crit :
>>
>>>> +/include/ "armada.dtsi"
>>>> +
>>>> +/ {
>>>> +	model = "Marvell Armada 370 family SoC";
>>>> +	compatible = "marvell,armada370", "marvell,armada";
>>>
>>> It should be mrvl, not marvell, in all the compatibility strings.
>>
>> Ok, we will change that.
>>
>>> Also, we need to be careful with armada. kirkwood is an armada for
>>> example. It maybe be better to not actually use armada without
>>> postfix.
>>
>> Do you have a recommendation for this? We support both Armada 370 and
>> Armada XP, so the obvious common prefix for these two platforms is
>> "armada". Since kirkwood are ARMv5 and those new Armada are ARMv7,
>> would armadav7 be a better prefix? Then we could have armadav7-370 and
>> armadav7-xp? Other suggestions?
>
> Please be carefull with what you'll choose. There's also Dove SoCs
> which are v7 too (88AP510 / armada 510 in Marvell namings). I would be
> tempted to use "mrvl,dove" like was what was used for kirkwood so this
> won't conflict but still, can be quite confusing.

For the device tree naming, I would go for the device's manufacturing
code simply to ensure that there is no confusion about what is being
supported.

For further compatibility fields, I'm not sure on how good it would be
to put things that are not at-least sub-sets of what is being supported
in the compatibilty line... We'd like to avoid changing the kernel too
much, but adding an extra line or two to selected drivers is not difficult.

The actuall CPU core shouldn't really come in to it, as that is taken
care of elsewhere in the kernel initialisation sequence.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
