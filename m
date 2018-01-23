From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 24 Jan 2018 02:44:27 +0800
Subject: [PATCH 05/12] arm64: dts: mt7622: add PMIC MT6380 related nodes
In-Reply-To: <CAOFm3uHnUk8BwDVR0F+5VqTB+8qFKz23ooX3o9G_RCbVqpbQPw@mail.gmail.com>
References: <CAOFm3uHnUk8BwDVR0F+5VqTB+8qFKz23ooX3o9G_RCbVqpbQPw@mail.gmail.com>
Message-ID: <1516733067.15199.41.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, Philippe

Really appreciate your info and detailed explanation. it's clear how
correct way to add GPDX license identifier. I will have a follow-up.

	Sean

On Tue, 2018-01-23 at 11:46 +0100, Philippe Ombredanne wrote:
> Sean,
> sorry for the late reply and thanks you for this research.
> 
> On Fri, Jan 12, 2018 at 4:33 AM, Sean Wang <sean.wang@mediatek.com> wrote:
> > Currently, I'm really confused about what usage STYLE of SPDX license
> > identifier I should use for each type of file.
> >
> > could you point me where I can find the related document describing SPDX
> > usage style for those files expected by the community in the future?
> 
> The doc is in this patchset [1]
> 
> [1] https://lkml.org/lkml/2017/12/28/326
> 
> 
> > I found more than one way STYLE of SPDX present at current code, for
> > example as below. If there's no absolute definition for them, and then
> > which way that is better?
> > 1)
> > for *.dts, applied with "// " at head or within " /* */ " not at head
> > such as
> >
> > arch/arm/boot/dts/bcm953012hr.dts:2: *  SPDX-License-Identifier:
> > BSD-3-Clause
> 
> This is a "style bug". The comment style for .dts should be //
> 
> > 2)
> > for *.c, applied with "// " at head or within " /* */ " not at head
> > such as
> > drivers/soc/xilinx/zynqmp/pm.c:10: * SPDX-License-Identifier:   GPL-2.0+
> 
> This is a "style bug". The comment style for .c should be //
> 
> > 3)
> > for *.h, applied with "// " at head or within " /* */ " at head
> > such as
> > drivers/usb/dwc3/gadget.h:1:// SPDX-License-Identifier: GPL-2.0
> 
> This is a "style bug". The comment style for .h should be /**/
> 
> > 4)
> > no issue, Makefile, or Kconfig, definitely applied with "# " at head
> 
> That's the correct way.
> 
> So the net-net is that these "style bugs" should be fixed.
> 
