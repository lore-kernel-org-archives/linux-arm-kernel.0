From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Tue, 3 Jul 2012 12:03:48 +0530
Subject: [FYI/RFC] usb: musb: DMA doesn't work with "nop" PHYs
In-Reply-To: <20120702223837.GA31796@animalcreek.com>
References: <20120702223837.GA31796@animalcreek.com>
Message-ID: <CAAe_U6+zBUvQV0bDG3cmYzXcxH7NjVye0oe1fM1AtdnG6Wfs0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Couple of questions..

On Tue, Jul 3, 2012 at 4:08 AM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> [The reason I'm sending this is that there is an issue but I probably
> ?won't be able to spend much time on it for a while. ?So, I'm sending
> ?it in case a) it helps someone else who bumps into it and b) someone
> ?else picks up and completes the fix.]
>
> Hello.
>
> In testing USB OTG Gadget on the am37x EVM with the mainline kernel
> I discovered that DMA doesn't work (but PIO does). ?When I tested
> the same kernel on the BeagleBoard-xM (BBxM), which has essentially
> the same SoC, it worked fine. ?They do have different OTG PHYs, though.
> The am37x EVM uses an ISP 1507 and the BBxM uses the PHY on the
> TPS65950 (twl4030). ?The different PHYs means that they use different
> drivers in drivers/usb/otg. ?The am37x EVM uses nop-usb-xceiv.c and
> the BBxM uses twl4030-usb.c.

Where does the comparator (VBUS) exist in am37x? Who will be first
interrupted when a cable is connected?

Thanks
Kishon
