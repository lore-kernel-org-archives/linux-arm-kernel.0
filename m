From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 16 Nov 2014 10:38:35 +0100
Subject: dtb size limit? was Re: Tiny dts change breaks boot on n900
In-Reply-To: <20141110125806.GA16650@amd>
References: <20141110123118.GA31134@amd>
	<20141110125806.GA16650@amd>
Message-ID: <CAMuHMdUPxSZNPb=sv=OKfr5_PcHrBph=v5RVBb5Pp5DiW0pP9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 1:58 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Breaks the boot. I'm using dtb append option. Any ideas? Nonbooting
> dtb is 68910 bytes.

Perhaps because it's not a multiple of 4?

$ factor 68910
68910: 2 3 5 2297

Does padding some property with 2 bytes help?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
