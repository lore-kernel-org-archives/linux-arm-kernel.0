From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Oct 2015 15:45:32 -0300
Subject: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
In-Reply-To: <20151006181806.GS21513@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
 <20151006181806.GS21513@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DaowTGQqN_NW7T2zv-P6a_YZUCumq4-m+OtpsKqFzELw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 3:18 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Sorry, I've been out for most of the day.  There's no DT patches required.
>
> The dw_hdmi bridge driver creates its own platform device for the audio,
> which should then bind to the dw_hdmi-ahb-audio driver using normal Linux
> methods.
>
> I don't know what's wrong with your setup, for me, it just works:
>
> [    1.358829] dwhdmi-imx 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
> [    1.377173] imx-drm display-subsystem: bound 120000.hdmi (ops dw_hdmi_imx_ops)
> ...
> [    2.851343] ALSA device list:
> [    2.857364]   #0: DW-HDMI rev 0x0a, irq 21
>
> as it always has done for me.  There's nothing special about it.

Great, got it to probe now:

[    7.454760] ALSA device list:
[    7.457764]   #0: DW-HDMI rev 0x0a, irq 19
[    7.461990]   #1: wm8962-audio

There was a conflict and I resolved incorrectly here. Will try to play
a wav file via aplay now.

Thanks
