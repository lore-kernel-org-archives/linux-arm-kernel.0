From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 28 Apr 2017 18:16:46 +0200
Subject: [PATCH] arm64: Print DT machine model in setup_machine_fdt()
In-Reply-To: <20170428145730.GS13675@arm.com>
References: <1493296385-14140-1-git-send-email-geert+renesas@glider.be>
 <20170428145730.GS13675@arm.com>
Message-ID: <CAMuHMdVHMcY5iy3gsYUOJLhYnMECh4yu-5pZJHXNxJhBp6+TOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Apr 28, 2017 at 4:57 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Apr 27, 2017 at 02:33:05PM +0200, Geert Uytterhoeven wrote:
>> On arm32, the machine model specified in the device tree is printed
>> during boot-up, courtesy of of_flat_dt_match_machine().
>>
>> On arm64, of_flat_dt_match_machine() is not called, and the machine
>> model information is not available from the kernel log.
>>
>> Print the machine model to make it easier to derive the machine model
>> from an arbitrary kernel boot log.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> I have scripts to save kernel boot logs, and compare logs[*] for
>> subsequent boots on the same machine.  Having a way to extract the
>> machine model from an arbitrary kernel boot log makes this easier.

> I think your use-case is slightly questionable (e.g. for ACPI, we print
> something different, and this isn't generally considered to be ABI), but
> the patch is harmless and if you find it useful then:

Not having access to an ARM ACPI system, what does it print for example?

I don't consider it ABI, though, just informational.

> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
