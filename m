From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Jul 2015 09:50:50 -0300
Subject: Passing arguments to cmdline or changing the devicetree node??
In-Reply-To: <559BD921.3080000@eurek.it>
References: <559BD921.3080000@eurek.it>
Message-ID: <CAOMZO5COZb08E-Bwkt+yBHwOxRwzOYuG9k9Q6nvsw+dwchz4uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 7, 2015 at 10:50 AM, gianluca <gianlucarenzi@eurek.it> wrote:
> Hello list,
> I was thinking which is the best method to ensure a fallback compatibility
> to old boards when a single board has changed something in hardware.
>
> I will explain better:
>
> I designed a board running linux (on iMX28) which had 128MB and the first
> stage bootstrap is programming the DDR2 controller to match the memory
> timings.
> The bootloader had the memory size hardcoded, but it is not a problem
> because nothing on the bootloader is using it (maybe some atag for old
> compatibility, I need to check this out)
> The bootloader now loads linux and the devicetree flattened blob and pass it
> to the kernel.
> In the .dts I have a node called:
>
>>         memory {
>>                 reg = <0x40000000 0x08000000>;
>>         };
>
>
> and it is fixed.
>
> Now we need to update the memory onboard up to 256Mb or 512Mb, and if I can
> test easily on the fist stage bootstrap (programming the DDR2 controller for
> 256Mb and writing on memory above 128Mb and if it works I have could have
> 256Mb or more, for example) I need a procedure to change the memory node on
> the dts.

You could simply remove the memory node from your dts and let the
bootloader pass it to the kernel.

Regards,

Fabio Estevam
