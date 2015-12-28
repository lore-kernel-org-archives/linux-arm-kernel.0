From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Dec 2015 16:56:12 +0100
Subject: [PATCH v1 0/6] misc: add reboot mode driver
In-Reply-To: <3460735.DIRnhNBgbJ@wuerfel>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
 <567A6A01.8080305@rock-chips.com> <3460735.DIRnhNBgbJ@wuerfel>
Message-ID: <3171716.cOpneyGyL8@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 28. Dezember 2015, 16:28:55 schrieb Arnd Bergmann:
> On Wednesday 23 December 2015 17:31:45 Andy Yan wrote:
> > +        { .compatible = "rockchip,reboot-mode-nvram",
> > +                .data = (void *)&reboot-mode-nvram },
> > +        {},
> > +};
> 
> nvram is a complex topic by itself, because there are so many ways to do it.
> I think what you are referring to here is a battery-backed memory that uses
> one or more bytes at a fixed offset to store a particular piece of
> information, as the drivers/char/nvram.c driver does. Maybe we should put
> the reboot mode into that driver then?
> 
> There are other nvram drivers at various places in the kernel, and each may
> be slightly different, or completely different, like the EFIVARs driver on
> UEFI firmware or the key/value store on Open Firmware, these probably need
> their own methods and not share the generic driver.

actually we now have drivers/nvmem/* that does that byte-wise addressing for 
eeproms, efuses, etc in a generic way.
