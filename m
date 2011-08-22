From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Aug 2011 09:27:00 +0100
Subject: [PATCH 00/19] GPIO exodus and cleanup
In-Reply-To: <CACRpkdbPFuFHBuHzO2bP+z=za2kOFk4AZdgMVy=U6kcMmw9LSw@mail.gmail.com>
References: <1312978564-18069-1-git-send-email-linus.walleij@stericsson.com>
	<20110817090123.GD1006@n2100.arm.linux.org.uk>
	<CACRpkdbJOrb5rhgG0Chamt-ApLQnV69MQ=bqBwKqO3KJPaFd0A@mail.gmail.com>
	<CACRpkdYw96QD0sGOhA=osKYbnD6=MTqiAF=m5++BjM-s1Mn--w@mail.gmail.com>
	<CACxGe6tEOnUzFjKMqNfp10b8SyuJDDFzg0eiPzhKNNCY55LECw@mail.gmail.com>
	<CACRpkdbPFuFHBuHzO2bP+z=za2kOFk4AZdgMVy=U6kcMmw9LSw@mail.gmail.com>
Message-ID: <20110822082700.GK12028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 09:53:48AM +0200, Linus Walleij wrote:
> On Sun, Aug 21, 2011 at 9:09 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Fri, Aug 19, 2011 at 5:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >> Ping on this, on monday I'll pretend it's no big deal and pour them
> >> into Russells patch tracker anyway, since he's managing more than
> >> half of the kernels GPIO code in arch/arm/* anyway.
> >
> > If Russell is okay with it, then go ahead and merge it. ?I'm being
> > pretty liberal about GPIO driver moves. ?I'm fine with them getting
> > cleaned up after the drivers/gpio move.
> 
> Okay! Russell I've put them into your patch tracker as patches
> 7032/1 thru 7050/1 so you can pick and choose. I've rebased on
> top of what's in -next hoping that the stuff there affecting these
> file will mainly be identical to what's on your "gpio" branch.
> 
> Tell me if I should rebase on something specific or if there are
> any problems.

I've applied as many as I can, but 7042/1, 7046/1, 7047/1 and 7048/1
failed:

Patching 7042/1...
git apply --whitespace=fix -p1 --index --check > /tmp/pdb.26923 2>&1 exited with non-zero status: 256
error: patch failed: drivers/gpio/gpio-ep93xx.c:24
error: drivers/gpio/gpio-ep93xx.c: patch does not apply
Patching 7046/1...
git apply --whitespace=fix -p1 --index --check > /tmp/pdb.26923 2>&1 exited with non-zero status: 256
error: patch failed: arch/arm/mach-mmp/gplugd.c:9
error: arch/arm/mach-mmp/gplugd.c: patch does not apply
error: drivers/gpio/gpio-pxa.c: does not exist in index
Patching 7047/1...
git apply --whitespace=fix -p1 --index --check > /tmp/pdb.26923 2>&1 exited with non-zero status: 256
error: patch failed: drivers/gpio/Makefile:40
error: drivers/gpio/Makefile: patch does not apply
Patching 7048/1...
git apply --whitespace=fix -p1 --index --check > /tmp/pdb.26923 2>&1 exited with non-zero status: 256
error: drivers/gpio/gpio-pnx4008.c: does not exist in index

It looks like there are changes to these in other trees which conflict.
