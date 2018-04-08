From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 8 Apr 2018 13:37:11 +0200 (CEST)
Subject: btbcm: possible circular locking dependency linux-next-20180327
In-Reply-To: <CALeDE9PFN-ELtQ1kPExKzn1UoO9yct+wR7Aaz=p9xU4zzF1Zyw@mail.gmail.com>
References: <1287361811.42067.1522496963924@email.1und1.de>
 <CALeDE9PFN-ELtQ1kPExKzn1UoO9yct+wR7Aaz=p9xU4zzF1Zyw@mail.gmail.com>
Message-ID: <1947919954.98203.1523187431990@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> Peter Robinson <pbrobinson@gmail.com> hat am 31. M?rz 2018 um 15:16 geschrieben:
> 
> 
> On Sat, Mar 31, 2018 at 12:49 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Hi,
> >
> > i build linux-next-20180327 with bcm2835_defconfig, but additionally enabled the following settings:
> >
> > CONFIG_SMP=y
> > CONFIG_PREEMPT=y
> > CONFIG_PROVE_LOCKING=y
> >
> > If i boot my RPi Zero W, then i will get the following output during hci_uart probe:
> 
> I saw something similar, sorry don't have the exact bits close to
> hand, on the RPI3 on 4.16 when I applied the this patch [1],
> unfortunately I never got enough time to go back and debug it further.
> The description in the patch is a bit misleading too as it mentions
> it's specifically for the Zero W but applies the changes to
> thebcm283x.dtsi which affects all editions of the RPi.

yes the commit log is a little bit unlucky. But i'm pretty sure that a change on pinctrl settings has nothing to do with locking dependency.

Stefan

> 
> Peter
> 
> [1] https://patchwork.kernel.org/patch/10240919/
