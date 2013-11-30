From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 30 Nov 2013 12:52:38 +0400
Subject: =?UTF-8?B?UmU6IFtSRkMvUEFUQ0hdIE5BTkQgYnVzLXdpZHRoIGRldGVjdGlvbiBleHRy?=
 =?UTF-8?B?ZW1lIG1ha2VvdmVy?=
In-Reply-To: <20131130083537.GB29397@norris.computersforpeace.net>
References: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131130083537.GB29397@norris.computersforpeace.net>
Message-ID: <1385801558.849805040@f409.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> On Fri, Nov 29, 2013 at 10:40:55AM -0300, Ezequiel Garcia wrote:
> > Here's my proposal, based in Pekon's latest work.
> > 
> > This patch removes the flash device bus-width configuration, prior to
> > the device detection. With this modification, a NAND driver is no longer
> > able to "force" the device width, and instead can only obtain the detected
> > bus-width after the call to nand_scan_ident().
...
> > Alexander: Could you try this patch and see if it's suitable for your needs?
> > I think you should be able to use it to set the bus-width, without any need for
> > a new DT property. You will have to split your nand_scan() call in an initial
> > call to nand_scan_ident() and a final call to nand_scan_tail().
> 
> FWIW, gpio.c does not need to split nand_scan(), as it doesn't need any
> custom call-backs. nand_base should do all the work.

I agree, there are no need to split.
I'll test this on Monday.

---
