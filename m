From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Sep 2014 13:52:49 +0200
Subject: [PATCH 6/6 v4] ARM: realview: basic device tree implementation
In-Reply-To: <20140725152401.GA21830@leverpostej>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <1406294628-16079-7-git-send-email-linus.walleij@linaro.org>
 <20140725152401.GA21830@leverpostej>
Message-ID: <CACRpkdaugAmVt5CF194xd+eVyz=Yfir6Jz0k9h4VSvSWLkKPRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM1176JZF confusion in as separate thread...

On Fri, Jul 25, 2014 at 5:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jul 25, 2014 at 02:23:48PM +0100, Linus Walleij wrote:

>> +               /* Primary DevChip GIC synthesized with the CPU */
>> +               intc_dc1176: interrupt-controller at 10120000 {
>> +                       compatible = "arm,arm1176jzf-gic";
>
> As far as I am aware, the JZF flags haven nothing to do with the GIC
> implementation. I think they can be dropped from this string (following
> the example of "arm,arm1176-pmu").

FWIW I changed the string to "arm,arm1176-gic"

But this isn't about the CPU actually. It is the ARM1176JZF development
chip. See:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0375a/DDI0375A_arm1176jzf_dev_chip_r0p0_trm.pdf

I know it is confusingly named as a name of a SoC that has this
CPU inside it but what can I do ... some guys named ARM came
up with this.

Should use the string "arm,arm1176jzf-devchip-gic"?

>> +               /* This GIC on the board is cascaded off the DevChip GIC */
>> +               intc_pb1176: interrupt-controller at 10040000 {
>> +                       compatible = "arm,arm1176jzf-gic";
>
> And this isn't part of the CPU, so that string doesn't look right. I'd
> at least like to see an additional string earlier in the list

This seems to be a follow-on to the above confusion.

Yours,
Linus Walleij
