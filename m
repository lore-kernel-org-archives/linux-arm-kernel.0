From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 10:40:29 +0100
Subject: ARM Linux Kernel Update
In-Reply-To: <CAMu38xLbRcOfdGLF+ozMA7G-tqzqykvsaDToY43sdMO4FP4b5w@mail.gmail.com>
References: <CADohWC9sCwFbhtryZi-EbOvcBayh_6O2bEjzFaLMxHYXYBEhQg@mail.gmail.com>
 <CAMu38xLbRcOfdGLF+ozMA7G-tqzqykvsaDToY43sdMO4FP4b5w@mail.gmail.com>
Message-ID: <9020659.GYXS8BbG6X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 22:43:53 Albino B Neto wrote:
> 2015-11-12 21:46 GMT-02:00 Satay Epic <satayepic@gmail.com>:
> > Hello,
> >
> > I've an ARM SL3516  board with Linux 2.6.15 and I've tool-chain setup.
> > I could able to compile the GPL source.  This board has red-boot.
> >
> > I would like to update the kernel to 3.8.24.  My first attempt so not
> > sure about anything I should know, gotchas  etc.
> >
> > Any advice about the compilation , config will be appreciated.

3.8.24 is also really old already, try going to 4.1 or 4.3 right away,
and submit any patches that you might need for integration into
mainline Linux once you are done.

See http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini;h=b74c3d8f0100e2ac8a4d71c4d23c082db2993e63;hb=HEAD

for a tree that has some of the missing parts for gemini, including a
config and some drivers that might be helpful. This is based on 4.1
and should be easy enough to forward-port to 4.3 if you want.

> > I tried using the  existing  ".config" but not sure some SL3512
> > specific options would work?

Start with the config-4.1 file from openwrt.

> > Looking at the distribution,  I don't see the  "mach-sl2312" listed.
> > Can you just copy it from the old distribution and does it work this
> > way?
> >
> > There is this "mach-gemini" but it seems only for some W boards.

mach-gemini is what you want.

	Arnd
