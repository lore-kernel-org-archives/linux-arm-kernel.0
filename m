From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 9 Jul 2016 22:37:31 +0300
Subject: How do /dev/ttyS* devices get assigned from the device tree?
In-Reply-To: <CAF_dkJBmgxyQLNtJqXWyQtzsmcK3QCqjYugsMG7MXGUdjL6nvA@mail.gmail.com>
References: <CAF_dkJBmgxyQLNtJqXWyQtzsmcK3QCqjYugsMG7MXGUdjL6nvA@mail.gmail.com>
Message-ID: <20160709193731.GA3870@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Fri, Jul 08, 2016 at 12:58:06PM -0400, Patrick Doyle wrote:
> Do they show up numerically in the sequence in which they appear in
> the device tree?
> 
> Where could I learn more?

Adding devicetree ML to Cc.

You may use an "aliases" node for that, if your UART driver supports that. The 
8250/16550 driver does. See arch/arm/boot/dts/aspeed-ast2500-evb.dts, for 
example. Note though that the use of aliases for this purpose is contentious.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
