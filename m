From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 02 Apr 2014 22:08:21 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNIGkuTVg1MTogQWRkIERpZ2kgQ29ubmVjdENvcmUg?=
 =?UTF-8?B?ZGV2aWNldHJlZQ==?=
In-Reply-To: <533C4FF5.1010402@gmail.com>
References: <1396075706-25384-1-git-send-email-shc_work@mail.ru>
 <20140402174458.GC27994@pengutronix.de>
 <533C4FF5.1010402@gmail.com>
Message-ID: <1396462101.127905311@f399.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 02 Apr 2014 19:59:17 +0200 ?? Dirk Behme <dirk.behme@gmail.com>:
> Am 02.04.2014 19:44, schrieb Robert Schwebel:
> > [adding Nicolas to Cc]
> >
> > On Wed, Apr 02, 2014 at 02:53:18PM +0200, Sascha Hauer wrote:
> >> On Wed, Apr 02, 2014 at 07:39:35PM +0800, Shawn Guo wrote:
> >>> On Sat, Mar 29, 2014 at 10:48:26AM +0400, Alexander Shiyan wrote:
> >>>> +&nfc {
> >>>> +	pinctrl-names = "default";
> >>>> +	pinctrl-0 = <&pinctrl_nfc>;
> >>>> +	nand-bus-width = <8>;
> >>>> +	nand-ecc-mode = "hw";
> >>>> +	nand-on-flash-bbt;
> >>>> +	#address-cells = <1>;
> >>>> +	#size-cells = <1>;
> >>>> +	status = "okay";
> >>>> +
> >>>> +	partition at 0 {
> >>>> +		label = "boot";
> >>>> +		reg = <0x00000 0x80000>;
> >>>> +	};
> >>>> +
> >>>> +	partition at 1 {
> >>>> +		label = "env";
> >>>> +		reg = <0x80000 0x40000>;
> >>>> +	};
> >>>
> >>> @Sascha, does the argument that we shouldn't have partition table in the
> >>> mainline dtb still stands?
> >>
> >> Yes, I still think the partitions shouldn't be in the Linux dts files.
> >
> > The dtb files for the Atmel Xplained board also has a partition
> > definition, so the same comment applies there, too.
> >
> > Besides being no hardware description, this implies a certain way of
> > using the system; for example, with the "kernel" plus "rootfs"
> > partitions, it suggests that you can't have the kernel in the standard
> > root filesystem (which is possible with barebox and the freedesktop.org
> > bootloader specification).
> 
> Just out of curiosity, because I never got a good answer to this 
> question (but maybe I asked the wrong way):
> 
> If not in the dts, where should the partition table be put instead, then?

It can be passed by kernel command line.

---
