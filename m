From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 22 Jul 2010 12:21:11 +0100
Subject: Introducing the LCD-Linux project
In-Reply-To: <AANLkTikitTGpiE5Oe_P5a4f2OCOnlB9j_LVm5CQhQIno@mail.gmail.com>
References: <AANLkTikitTGpiE5Oe_P5a4f2OCOnlB9j_LVm5CQhQIno@mail.gmail.com>
Message-ID: <20100722122111.4cf4ca2f@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Jul 2010 14:57:54 +0200
Mattia Jona-Lasinio <mattia.jona@gmail.com> wrote:

> Hi,
> 
> this is to introduce the LCD-Linux project (http://lcd-linux.sourceforge.net/),
> a kernel level implementation of a VT102 terminal emulator, optimized for small
> alphanumeric and graphic displays.

The kernel already has a console and that provides an abstract
implementation that is used for everything from text mode displays to vga
to assorted accelerated hardware platforms.

Why do we need a VT102 as well ?

> functions. A solution is therefore to provide a sort of minimal terminal
> emulation in kernel space, that can be accessed through the standard character
> device interface. In this way the problem of the display management is reduced

If you use the existing kernel console interfaces then you don't need to
worry about vt102 v console or having two terminal emulations running.

The basic idea seems sound enough other than that. Another reason for
using the kernel console/vt driver is that you can then also support mini
bitmap displays because a frame buffer driver backed by a driver for a
suitable LCD panel can work nicely because the vt driver can sit on the
fb layer quite happily and fb then implements low level handling for the
pixels.

Alan
