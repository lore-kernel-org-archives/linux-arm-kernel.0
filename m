From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Tue, 19 Nov 2013 09:47:42 +0800
Subject: [Inquiry] How to boot using USB device and configure PCI using
 OMAP4460/4470?
In-Reply-To: <20131114154505.GC15835@saruman.home>
References: <CAB8gEUt-_-w4wJkdo3bH7qiLOaqFusfL85rs58n00twD1qpxLA@mail.gmail.com>
 <20131114154505.GC15835@saruman.home>
Message-ID: <CAB8gEUtYG9agU2i=fEKocfw1wjvBDfHvo5=fLNpABeNtFiXSxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,
Good morning.

Thank you very much for the feedback.

> all you need to do is write a flasher and a small "bootloader" which
> knows about usb. ROM code can receive data via USB and jump to that
> data's entry point.
> It's all in the TRM.
OK, I will look into this.
However, it seems like this question (1) is not kernel-related.
Can you direct me to the correct contact person for this?

> that's because OMAP4 doesn't have a PCI controller.
But TI OMAP4470 Blaze Tablet 2 Development Platform contains PCI (miniPCIe).
How is Blaze 2 tablet's kernel configured then..?
# I based it on specs at http://msdn.microsoft.com/en-us/library/dn167241.aspx
# I also have actual Blaze 2 and it has miniPCIe ports, although I
haven't tested if it's working.

> you're on your own, sorry. You need to ask for support from whoever gave
> you that v3.0 kernel.
Ok, noted. Thank you.

Regards,
Maggie Roxas

On Thu, Nov 14, 2013 at 11:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Nov 14, 2013 at 01:34:14PM +0800, Maggie Mae Roxas wrote:
>> Hello,
>> Good day.
>>
>> I am currently developing a Panda board that uses OMAP4460/4470.
>> I have two questions.
>>
>> 1) I can boot it via SD.
>> But I would like to boot it using USB device connected in one of the 2 USB
>> ports (not from PC via USB connection).
>> Can you guide me on how to do this?
>> # I found some forums and howtos, but it discusses the usbboot (PC via USB
>> connection type of boot), which is not what I need..
>
> all you need to do is write a flasher and a small "bootloader" which
> knows about usb. ROM code can receive data via USB and jump to that
> data's entry point.
>
> It's all in the TRM.
>
>> 2) I have customized the actual board to have PCI connection, however, I
>> found out that OMAP kernel configurations does not support PCI (I am not
>> sure if u-boot does).
>
> that's because OMAP4 doesn't have a PCI controller.
>
>> BTW, I am using Linux Kernel v3.0, Android FS v4.3, Marvell U-Boot 1.1-4
>
> you're on your own, sorry. You need to ask for support from whoever gave
> you that v3.0 kernel.
>
> --
> balbi
