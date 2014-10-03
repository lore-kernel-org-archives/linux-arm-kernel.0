From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Oct 2014 18:04:11 +0200
Subject: [PATCH v3] dt-bindings: Add a clocks property to the
 simple-framebuffer binding
In-Reply-To: <CAL_JsqKU2n8p=YfJua3k-mR40bG_4SiZY8_-SL-MXtuWN5NeHg@mail.gmail.com>
References: <1412345120-24588-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqKU2n8p=YfJua3k-mR40bG_4SiZY8_-SL-MXtuWN5NeHg@mail.gmail.com>
Message-ID: <CAMuHMdVgaXoGXyJdD8PRufZQYLTSY=_ZWRRo=OtRo3mrg3uEug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Oct 3, 2014 at 5:57 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Oct 3, 2014 at 9:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> A simple-framebuffer node represents a framebuffer setup by the firmware /
>> bootloader. Such a framebuffer may have a number of clocks in use, add a
>> property to communicate this to the OS.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>
>> --
>> Changes in v2:
>> -Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
>> Changes in v3:
>> -Updated description to make clear simplefb deals with more then just memory
>
> NAK. "Fixing" the description is not what I meant and does not address
> my concerns. Currently, simplefb is configuration data. It is
> auxiliary data about how a chunk of memory is used. Using it or not
> has no side effects on the hardware setup, but you are changing that
> aspect. You are mixing in a hardware description that is simply
> inaccurate.
>
> The kernel has made the decision to turn off "unused" clocks. If its
> determination of what is unused is wrong, then it is not a problem to
> fix in DT.

The kernel has made that decision because the driver hadn't told the
kernel that those clocks had to be enabled.
The only way for the driver to know which clocks to enable is by adding
them to the description in DT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
