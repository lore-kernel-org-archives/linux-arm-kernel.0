From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Dec 2013 19:12:05 +0100
Subject: Can't boot newer kernel on Armada 370 dev board
In-Reply-To: <20131230174738.GA4172@enneenne.com>
References: <20131230174738.GA4172@enneenne.com>
Message-ID: <20131230181205.GA32362@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 06:47:39PM +0100, Rodolfo Giometti wrote:
> Hello,
> 
> I have an Armada 370 dev board (DB-88F6710-BP) running Marvell kernel
> 3.2.
> 
> Now I'm a bit puzzled because I'd like to use newer kernel (i.e 3.12)
> on my board, so I tried several repositories (vanilla and linux-mvebu)
> with no success! :'(
> 
> I read on the net that it should work, but after using the bootz
> command everything hangs:
> 
>    Marvell>> tftp $loadaddr zImage-cyone
>    Using egiga0 device
>    TFTP from server 192.168.32.38; our IP address is 192.168.32.25
>    Filename 'zImage-cyone'.
>    Load address: 0x2000000
>    Loading: #################################################################
>             #################################################################
>             #################################################################
>             #################################################################
>             #################################################################
>             #################################################################
>             #################################################################
>             #################################################################
>             ########
>    done
>    Bytes transferred = 2701021 (2936dd hex)
>    Marvell>> bootz $loadaddr
> 
>    Starting kernel ...
> 
> File zImage-cyone is made with command:
> 
>    giometti at hulk:~/Projects/linux-mvebu[mvebu-dt-3.14]$ cat arch/arm/boot/zImage arch/arm/boot/dts/armada-370-db.dtb > /srv/tftp/zImage-cyone
> 
> Someone have some advise for me! :)

Hi Redolfo

What version of u-boot do you have? There has been a change in u-boot
so that the registers are mapped to a different address. Old u-boot
with new kernel causes instant lockup on boot as soon as it tries to
access the wrong address space.

	Andrew
