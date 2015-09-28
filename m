From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2015 10:30:06 +0100
Subject: Build regressions/improvements in v4.3-rc3
In-Reply-To: <CAMuHMdWrBYnQ0CRYmBgO3xNZMqCY42OtNwhryqzi+Tv+KGj6Lg@mail.gmail.com>
References: <1443382476-12171-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWrBYnQ0CRYmBgO3xNZMqCY42OtNwhryqzi+Tv+KGj6Lg@mail.gmail.com>
Message-ID: <20150928093006.GT21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 08:57:44AM +0200, Geert Uytterhoeven wrote:
> On Sun, Sep 27, 2015 at 9:34 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v4.3-rc3[1] to v4.3-rc2[3], the summaries are:
> >   - build errors: +8/-12
> 
>   + error: No rule to make target include/config/auto.conf:  => N/A
> 
> arm-randconfig

Not every randconfig failure is a kernel problem.  Here's an example:

Physical address of main memory (PHYS_OFFSET) [] (NEW) aborted!

Console input/output is redirected. Run 'make oldconfig' to update configuration.

This needs someone to provide a value, which means these failures are
not in fact failures of the kernel, but a failure of the build system
to anticipate that there may be Kconfig questions that need input.

So, these ones should be ignored.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
