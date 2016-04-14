From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 14 Apr 2016 19:38:57 +0200
Subject: [PATCH 2/5] serial: imx: Use generic uart-has-rtscts DT property
In-Reply-To: <20160414172259.GA16348@rob-hp-laptop>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
 <1460636003-3011-3-git-send-email-geert+renesas@glider.be>
 <20160414172259.GA16348@rob-hp-laptop>
Message-ID: <CAMuHMdUQSAzFa9ErkjqNumLeOiGHeD51TUPJOSi2pXsdbJu3pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Apr 14, 2016 at 7:22 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Apr 14, 2016 at 02:13:20PM +0200, Geert Uytterhoeven wrote:
>> Convert the Freescale IMX UART driver from using the vendor-specific
>> "fsl,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
>> documented by the Generic Serial DT Bindings.
>>
>> The old vendor-specific property is still recognized by the driver for
>> backwards compatibility, but deprecated.
>
> You should update the dts files as well.

Indeed. But as I said in the cover letter:

"Actual DTS files are to be updated later, after this series has been
 integrated into mainline."

DTS updates typically go through a different path (e.g. arm-soc).
RTS/CTS support will be broken if the DTSes are updated before the drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
