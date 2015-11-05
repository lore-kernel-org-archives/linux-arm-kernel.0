From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2015 09:27:04 +0000
Subject: [PATCH 11/11] tty: amba-pl011: add support for ZTE UART
 (EXPERIMENTAL)
In-Reply-To: <CACRpkdbMUTUTJvCZXusMHDO4oqhXwo1DT8=h67ej9GSoDR5jvw@mail.gmail.com>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcw9-0007Cz-TX@rmk-PC.arm.linux.org.uk>
 <CACRpkdbMUTUTJvCZXusMHDO4oqhXwo1DT8=h67ej9GSoDR5jvw@mail.gmail.com>
Message-ID: <20151105092703.GN8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 09:28:23AM +0100, Linus Walleij wrote:
> On Tue, Nov 3, 2015 at 3:51 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Add (incomplete) support for the ZTE UART to the AMBA PL011 driver.
> > This is similar to the ARM and ST variants, except it has a different
> > register address layout, and requires 32-bit accesses to the registers.
> > Use the newly introduced register tables and access size support to
> > cope with these differences.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I applied the whole series, 1-11 and tested on Ux500 (ST Micro variant)
> and on the ARM RealView PB11MPCore.
> 
> It works like a charm. I also like the looks of this transformation.
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

As I mentioned, the change in pl011_putc() needs undoing (I've already
modified that in my series).  Also, I'll try switching to the relaxed
accessors and checking that.  Thanks for the tested-by though, can I
assume that you're happy I add that even with the pl011_putc() change
undone?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
