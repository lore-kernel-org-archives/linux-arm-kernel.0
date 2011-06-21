From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jun 2011 10:22:22 +0300
Subject: Trouble with newer kernels on Gumstix Overo boards
In-Reply-To: <BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
	<BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
Message-ID: <20110621072220.GA21159@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Mack <zonque@gmail.com> [110617 18:06]:
> On Fri, Jun 17, 2011 at 4:03 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> >> console=ttyS2,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
> >
> > Here is your problem. We now use the OMAP-serial driver for the UARTs.
> 
> Which breaks backward-compatibility with bootloaders set up for older
> kernels. Now I have to deploy kernels with CONFIG_CMDLINE_FORCE=y. Was
> that really necessary?

In most cases you can just setenv cmdline then saveenv in u-boot.

Who knows, maybe at some point we can make 8250.c behave with runtime PM
and Linux generic DMA API, but that might take a while before we get there :)

Regards,

Tony
