From: uwe@kleine-koenig.org (=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=)
Date: Fri, 25 Nov 2016 15:34:55 +0100
Subject: [RFC PATCH] ARM: dts: Add support for Turris Omnia
In-Reply-To: <1480078151.381.4@smtp.gmail.com>
References: <1479851991.26813.2@smtp.gmail.com>
 <1479859770-9375-1-git-send-email-tmshlvck@gmail.com>
 <20161123003505.GL2691@lunn.ch>
 <4e3f9628-dbf8-27c1-abea-d0ef58a67e51@kleine-koenig.org>
 <20161124150700.GD7155@lunn.ch> <1480078151.381.4@smtp.gmail.com>
Message-ID: <0d17c6df-ba75-1e0c-735e-f23b61388a04@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[trimmed Cc: a bit to annoy less]

On 11/25/2016 01:49 PM, Tomas Hlavacek wrote:
> On Thu, Nov 24, 2016 at 4:07 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>>  @Tomas: I think it doesn't make sense when we alternate sending patches
>>>  without prior arrangement. Do you already work on a v5? If not I can do
>>>  that to fix the last few comments. Not sure when a submission is too
>>>  late to enter v4.10, but I think the window isn't that big any more.
>>
>> It is getting a bit late. But maybe Linus will add in another -rc
>> week.

To keep the dice rolling I sent a v5 with is somewhere in the middle
between my v3 and Tomas RFC patch. Assuming Tomas is happy with this
change, can we still get it into 4.10? This would help me to put this in
the Debian kernel for the next release.

>>>  > No leds? No buttons via gpio-keys?
>>>
>>>  The leds are controlled by a Cortex-M0 and without intervention blink
>>>  according to a hardware function (network, power, pci). IMHO that's ok
>>>  for an initial setup.
>>
>> Yes. That is fine. It is just unusual. Most boards have gpio-led and
>> gpio-keys, which are easy to add. That is why i asked. Adding an LED
>> driver which talks to this M0 can be added later.
> 
> Actually the WiP driver for MCU LED interface, that we use in our kernel
> is here:
> https://github.com/tmshlvck/omnia-linux/commit/2121afd8fbd2e4c720edcdd472b11b5303bc0dfb
> 
> 
> It definitely needs some cleanup and it adds non-standard features (main
> PWM for all LEDs, autonomous blink mode, colors) via custom /sys files,
> which I suspect that is not going to be acceptable for upstream. Let's
> keep it for the next iteration.

Ack, the leds are one of the less critical things for the machine. I'd
like to tackle the switch next.

Best regards
Uwe

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 484 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/05e21cc2/attachment.sig>
