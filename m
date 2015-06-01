From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 1 Jun 2015 13:50:19 +0200
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <20150601105319.GQ2067@n2100.arm.linux.org.uk>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <CAMuHMdX=T3CsLTT95H_07Si6Kd8SRraBfxADpn+VtAF4GmZ=mw@mail.gmail.com>
 <CAMuHMdUQkm_9PhSdGS8j85Uodm-o0jiki=Xh4h59PBShB=rCXw@mail.gmail.com>
 <20150601105319.GQ2067@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdUXCy+87-pwLiJ7ynaM1AeFq0f7R3sJ4prdE3QN09z++w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jun 1, 2015 at 12:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 01, 2015 at 12:41:01PM +0200, Geert Uytterhoeven wrote:
>> FWIW, I have the feeling this has a slight influence on boot reliability on
>> two of my boards:
>>   - r8a7740/armadillo, which is known to suffer from a cache-related bug in
>>     its bootloader, seems to have a higher change of booting successfully on
>>     cold boot,
>>   - sh73a0/kzm9g, which has known cache-issues with secondary CPU boot up,
>>     seems to have a lower chance of booting successfully.
>>
>> No time to spend all week turning this into a statistical significant test
>> project... The reset button is my friend...
>
> Damn it, you sent this right after I merged and pushed out this change in
> my for-arm-soc branch, and was just about to send it to the arm-soc people.
> What excellent timing you have. :)

Don't worry, I didn't send that email to make you postpone this change.
Giving the fuzziness of reproduction, and the flakiness (esp. on Armadillo)
of the boot loader, and these are old SoCs, please go ahead.

> What happens on the kzm9g if you revert the mach-shmobile changes?

Seems to make no difference.

> For armadillo, do you use the decompressor?  That should be doing all the
> cache cleaning already, prior to the kernel being entered.

I think so.

Corruption pattern ranges from lock up, over "Error: unrecognized/unsupported
machine ID", to booting almost completely, but lacking a few devices due to
a corrupted DTB. Been like that as long as I remember, i.e. since I got the
board ca. 1 year ago. Boots fine (100%) with kexec.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
