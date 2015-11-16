From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 16 Nov 2015 19:56:03 +0100
Subject: [PATCH, resend] scsi: advansys: fix big-endian builds
In-Reply-To: <20151116182031.GX8644@n2100.arm.linux.org.uk>
References: <4411376.blKgWIg75B@wuerfel>
 <20151116182031.GX8644@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdX7O2LD_F2eomSEyBPKfpcgLbZRPzqRGBkqFVPx5s6mdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 7:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 16, 2015 at 05:49:23PM +0100, Arnd Bergmann wrote:
>> It turns out that the commit that introduced this used the cpu_to_le32()
>> incorrectly on an 8-bit field, which results in the sense_len to always
>> be set to zero, as the SCSI_SENSE_BUFFERSIZE value gets moved to upper
>> byte of the 32-bit intermediate.
>
> More people need to run the sparse checker with -D__CHECK_ENDIAN__ and
> have proper endian annotations?

Sure.

But in this case, it shows up as a normal compiler warning on all big endian
platforms.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
