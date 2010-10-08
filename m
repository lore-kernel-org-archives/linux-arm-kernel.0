From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 08 Oct 2010 20:53:57 +0200
Subject: unrecognized/unsupported machine ID
In-Reply-To: <4CAF6397.50403@gmail.com> (Tuomas Vainikka's message of "Fri\,
	08 Oct 2010 21\:31\:51 +0300")
References: <4CAF6397.50403@gmail.com>
Message-ID: <87vd5czfay.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tuomas Vainikka <tvainikk@gmail.com> writes:

> Hello,

Hi,
>
> I compiled linux 2.6.35.7 stable release from kernel.org, loaded it to
> RedBoot and got this:
>
> EM-7210 (RAM mode) 2005-12-22
> == Executing boot script in 5.000 seconds - enter ^C to abort
> ^C
> RedBoot> load -v -r -b 0x01008000 -m tftp zImage-20101005
> /
> Raw file loaded 0x01008000-0x011e7187, assumed entry at 0x01008000
> RedBoot> exec
> Using base address 0x01008000 and length 0x001df188
> Uncompressing Linux... done, booting the kernel.
>
> Error: unrecognized/unsupported machine ID (r1 = 0x00000147).

default redboot is using the wrong machine id (iirc iq31244 machine id)
so you have to use things like devio to modify r1 register before
booting the kernel. I use a script doing roughly that :

(
  devio 'wl 0xe3a01c04,4' 'wl 0xe38110bc,4'
  cat arch/arm/boot/zImage
) > arch/arm/boot/zImage.ss4000e

And then, use the zImage.ss4000e.

Arnaud
