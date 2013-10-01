From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 1 Oct 2013 14:18:08 +0100
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
In-Reply-To: <CACRpkdZygLfbE=kC6E+sRDRwZsY-Oi-HOB2mf6G7LeX-=XrcgQ@mail.gmail.com>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
 <201310011328.57653.arnd@arndb.de>
 <CACRpkdZygLfbE=kC6E+sRDRwZsY-Oi-HOB2mf6G7LeX-=XrcgQ@mail.gmail.com>
Message-ID: <CAGVrzcarF8aOqbp9rTcU8opONoejK_O+h93-0__=5fRS+bqxhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/10/1 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Oct 1, 2013 at 1:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 01 October 2013, Linus Walleij wrote:
>>> This converts the gemini machine to use generic clockevents
>>> by rewriting the timer driver.
>>
>> I've put a few more people on Cc that I think have access to hardware, according
>> to the openwrt changelog for gemini.
>
> Thanks, if the fine OpenWRT folks can suggest a cheapo piece of equipment
> that is fully supported by OpenWRT and that I can eBay to test my patches on
> my own I'm all ears.

I can't remember off the top of my head what exact hardware Tomasz
Figa handed to me (could probably find it somewhere tomorrow).

>
>> I've suggested removing the platform before, but got the feedback that it's
>> actively maintained in openwrt. Unfortunately we didn't get much
>> activity to upstream the patches from
>> http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini/patches
>> which are apparently required.
>
> Both with OpenWRT and OpenEmbedded we are seeing this forking
> instead of working with actively upstreaming and reducing the patch
> stack. This is not so nice, we need to discuss what can be done to
> reduce the patch stacks carried by other Open Source projects such
> as these.

I definitively agree, this has been a bad practice over the years, and
even though some of us have tried to resolve that, we are still not
quite there yet.

>
>> Rather than deleting the platform entirely, I'd be more inclined to accept
>> any cleanup patches like yours, testing or not, and let the downstream
>> users deal with fixing it up if it breaks. The ideal case of course would
>> be for someone to actively maintain the platform again and submit any patches
>> that are needed.
>
> Yeah :-/
>
> As with any other platform with an active community interested in
> long-term support it'd be best if someone stepped up to do
> the necessary conversion to DT and maybe also multiplatform
> (no idea if that works with the FA526 CPU though) so we can get
> the maintenance burden down for everone involved.
>
> I suggested project like this for the advanced kernel newbies
> actually... let's see if it takes hold.

One big prerequisite is having actual hardware support, we can
probably work out something to give these people access to hardware
(either remotely or physically).

Does not anybody actually have a farm of "old" ARM-based platforms
besides Olof? That way we could just ship the device to someone kind
enough to get some power supply + network + serial + JTAG/system
reset?
-- 
Florian
