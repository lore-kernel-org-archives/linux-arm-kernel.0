From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 13:55:52 -0700
Subject: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX
In-Reply-To: <CAFoWwXv2GjWt2+sCYqM+vbtJ5xJBJAJMSuZhjKLKtURQ0eziVw@mail.gmail.com>
References: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com>
 <20120924171858.GG28835@atomide.com>
 <CAGm1_ks_GvSTH8DJ6d3R5OjPNEOhQ39hNo4grg1Pn-NqFX5VKQ@mail.gmail.com>
 <20120924231619.GA28941@n2100.arm.linux.org.uk>
 <20120925003758.GP28835@atomide.com>
 <506165CA.7070406@visionsystems.de>
 <20120925081449.GF31374@n2100.arm.linux.org.uk>
 <50616B21.3070909@visionsystems.de>
 <CAFoWwXv2GjWt2+sCYqM+vbtJ5xJBJAJMSuZhjKLKtURQ0eziVw@mail.gmail.com>
Message-ID: <20121008205552.GC13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dejan Ga?nik <dejan.gacnik@gmail.com> [120927 07:13]:
> 
> I and my colleagues have developed a brand new very enhanced board having
> AM35xx CPU, 512MB DDR2, DVI, true dual Ethernet support (not using PRUSS),
> CAN, SPI, I2C, 7 USBs, etc?Board is already materialized and operational.
> 
> 
> According to our board we have create new machine type in the kernel
> (version: linux-3.2-psp04.06.00.07.sdk) and all other required stuff to
> support our board, modify some things, like adding support for dual eth,
> etc. Our goal is to provide this new board to the market (let say with
> large quantity) and therefore I am wondering how to start or if it is even
> possible to transfer our kernel change the main stream of this distro?
> During this kernel modification process we have been looking to not
> changing anything in kernel, what could affect other machine types.

For the mainline kernel, you should go with device tree based booting
to start with, we are no longer adding new board-*.c files. For older
distro kernels you need to maintain a separate board-*.c file until
we have moved everything to use device tree and distros are using
that kernel.

Regards,

Tony
