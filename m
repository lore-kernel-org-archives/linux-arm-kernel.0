From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 15 Oct 2015 00:07:18 +0200
Subject: bcm4708-smartrg-sr400ac boot failures in next-20150918+
In-Reply-To: <1444817059.13276.13.camel@pengutronix.de>
References: <CANMBJr5FnRQxv01CbAiSD43dGn+Ea4tjEWSsV1FywHJZYLnG_A@mail.gmail.com>
 <560DA9B9.80404@hauke-m.de> <561AE788.6030701@hauke-m.de>
 <CANMBJr4H1C6CHdRXa_NL9dssYGLkpRKAPXCMOV0FsUdb8JiSXg@mail.gmail.com>
 <1444816125.13276.8.camel@pengutronix.de>
 <20151014095633.GP32532@n2100.arm.linux.org.uk>
 <1444817059.13276.13.camel@pengutronix.de>
Message-ID: <561ED216.3070204@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 12:04 PM, Lucas Stach wrote:
> Am Mittwoch, den 14.10.2015, 10:56 +0100 schrieb Russell King - ARM
> Linux:
>> On Wed, Oct 14, 2015 at 11:48:45AM +0200, Lucas Stach wrote:
>>> I think we really want to keep enabling the imprecise aborts as early as
>>> possible to catch them near the spot where they did happen.
>>
>> Agreed.

I was never against this patch I just wanted to point out that it caused
a regression and we should fix it, I was just a little bit frightened to
add some early init code into a callback which gets called before early
init.

>>> So I think the right thing to work around your broken bootloader is to
>>> install the fault handler earlier. Russell, do you have any objections
>>> to that?
>>
>> How about installing the fault handler early before enabling the imprecise
>> aborts, and have the fault handler print a complaint about the broken
>> boot loader, and have the fault handler uninstall itself after the
>> imprecise abort has been enabled?
>>
> We might point at the bootloader a bit too often this way, as there is
> quite a bit of kernel code running before we can enable imprecise
> aborts. But I like the idea in general as it would allow us to drop
> those workaround from the individual architectures and move things into
> common code.

Lucas patches fixed the problem for me on a bcm4708 based device with a
broken boot loader. I assume Lucas patches will make it into mainline
and this issue is now solved for me.

>> If there's a pending imprecise abort, it should be delivered as soon as
>> they're unmasked.
>>
> Right.

Hauke
