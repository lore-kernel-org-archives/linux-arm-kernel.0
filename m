From: zonque@gmail.com (Daniel Mack)
Date: Fri, 17 Jun 2011 17:11:26 +0200
Subject: Trouble with newer kernels on Gumstix Overo boards
In-Reply-To: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
Message-ID: <BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2011 at 4:03 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> console=ttyS2,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
>
> Here is your problem. We now use the OMAP-serial driver for the UARTs.

Which breaks backward-compatibility with bootloaders set up for older
kernels. Now I have to deploy kernels with CONFIG_CMDLINE_FORCE=y. Was
that really necessary?

> Change the ttyS2 to ttyO2 and you should be fine.

You're right, that did the trick. Thanks a lot!

Daniel
