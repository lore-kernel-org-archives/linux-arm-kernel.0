From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 19 May 2017 11:01:39 +0800
Subject: [linux-sunxi] [PATCH v6 9/9] arm64: allwinner: a64: enable Wi-Fi
 for Pine64
In-Reply-To: <20170518071653.36561-10-icenowy@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-10-icenowy@aosc.io>
Message-ID: <CAGb2v66mqMveibKKU9LiBm8jzAOj46hFCK6HvJx0k6077fqLZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 18, 2017 at 3:16 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The Wi-Fi module of Pine64 is powered via DLDO4 and ELDO1 (the latter
> one provides I/O voltage).
>
> Add device node for it.
>
> Although the Wi-Fi module is an external module which should be inserted
> to a header, according to my personal talk with TL Lim, he does not want
> this header to be used as GPIO (so it's with 2.0mm pitch, not 2.54mm as
> other GPIO headers).

The patch looks OK, but given the module is removable, I think it should be
an overlay. The overlay would enable WiFi + Bluetooth, and all the
peripherals needed to connect them.

That way, if the module is not installed, we avoid confusing the user with
unused peripherals, and avoid having live voltage on an unoccupied header.

ChenYu
