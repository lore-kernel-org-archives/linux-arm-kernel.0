From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Mon, 23 Nov 2009 15:40:09 -0200
Subject: [PATCH] MX27: Add USB platform devices and resources
In-Reply-To: <37367b3a0911230937v4d623b6j58a69e09ccdc2925@mail.gmail.com>
References: <eedb5540907150626m3dbf815bif92ff179b6ebfe58@mail.gmail.com>
	<20090716081235.GQ2714@pengutronix.de>
	<37367b3a0911230436i5d44cd80y182316ef056d6b31@mail.gmail.com>
	<37367b3a0911230718s3dd16d99n1b2ce858b79218ca@mail.gmail.com>
	<20091123153111.GM14091@buzzloop.caiaq.de>
	<37367b3a0911230937v4d623b6j58a69e09ccdc2925@mail.gmail.com>
Message-ID: <37367b3a0911230940x7e8eb165p402016fb048366c0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry I found it!

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-07-usb/usb-otg-add-support-for-ulpi-connected-external-transceivers.patch

/me doing like a KLB

On 11/23/09, Alan Carvalho de Assis <acassis@gmail.com> wrote:
> Hi Daniel,
>
> On 11/23/09, Daniel Mack <daniel@caiaq.de> wrote:
>>
>> The patch you refer to only contains the relevant bits for MX31, you
>> would need to tweak it a little to make MX27 work as well. I think this
>> has been done already by someone, but I can't remember exactly.
>>
>
> I am getting this error when compiling your driver:
>
>   LD      drivers/usb/core/usbcore.o
>   LD      drivers/usb/core/built-in.o
>   CC      drivers/usb/host/ehci-hcd.o
> In file included from drivers/usb/host/ehci-hcd.c:1107:
> drivers/usb/host/ehci-mxc.c: In function 'ehci_mxc_drv_probe':
> drivers/usb/host/ehci-mxc.c:209: error: 'struct otg_transceiver' has
> no member named 'io_priv'
> drivers/usb/host/ehci-mxc.c:210: error: implicit declaration of
> function 'otg_init'
> drivers/usb/host/ehci-mxc.c:212: error: implicit declaration of
> function 'otg_set_vbus'
> drivers/usb/host/ehci-mxc.c: In function 'ehci_mxc_drv_remove':
> drivers/usb/host/ehci-mxc.c:258: error: implicit declaration of
> function 'otg_shutdown'
> make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
> make[2]: *** [drivers/usb/host] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
>
> What other patches need I to apply before applying your patch?
>
> Best Regards,
>
> Alan
>
