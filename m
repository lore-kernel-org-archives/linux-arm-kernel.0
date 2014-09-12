From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 12 Sep 2014 12:10:37 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <20140912095821.GB1930@katana>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <9935938.eKOCvCAtLt@fb07-iapwap2> <20140912083348.GA1289@katana>
 <7627175.tG5quZH0VN@fb07-iapwap2> <20140912095821.GB1930@katana>
Message-ID: <CAMuHMdVi+6TXH68ddQ-UWfUif0Mv=ETu6dnpiy1Apike6zfAbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, Sep 12, 2014 at 11:58 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> 2) Slave mode is needed for board bringup
>
> Some other components need a specific I2C slave to be present before
> userspace is available, otherwise the system is unusable. This is IMO
> then a hardware description and justifies DT entries:

OK, I didn't think this case, which is similar to an external device requiring
a GPIO to be at a specific level.

> DT pseudocode:
>
>         i2c {
>                 compatible = "nvidia, tegra-i2c";
>
>                 ec-slave at 42 {
>                         compatible = "nvidia, ax100-ec-slave";
>                         reg = <0x42>;
>                 };
>         };

So distinguishing between drivers providing slave services (using slave
mode) and drivers driving actual slave hardware (using master mode) is
done based on the compatible-property.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
