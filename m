From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Sep 2009 15:53:03 +0100
Subject: [PATCH v2 RESEND 1/2] ARM: Introduce ARM_L1_CACHE_SHIFT to
	define cache line size
In-Reply-To: <cc557aab0909120738t725fa53cm9277010e656c8ea4@mail.gmail.com>
References: <1252771155-5828-1-git-send-email-kirill@shutemov.name>
	<a9bd121a726831bc30f4ec04235eda667e602615.1252770642.git.kirill@shutemov.name>
	<4AABA3F7.2050301@ru.mvista.com>
	<cc557aab0909120712j354238c3oe3396591287b5562@mail.gmail.com>
	<4AABAE4D.6050909@ru.mvista.com>
	<cc557aab0909120738t725fa53cm9277010e656c8ea4@mail.gmail.com>
Message-ID: <20090912145303.GA15899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 12, 2009 at 05:38:31PM +0300, Kirill A. Shutemov wrote:
> On Sat, Sep 12, 2009 at 5:21 PM, Sergei Shtylyov
> <sshtylyov@ru.mvista.com> wrote:
> > Hello.
> >
> > Kirill A. Shutemov wrote:
> >> You can write anything in your .config (like 2+3), so I think parens is
> >> needed.
> >>
> >
> > ?You can -- but that won't be an integer option.
> 
> But kernel will be still compilable, but broken.
> 
> I think parens for defines from .config is a good practice.

However, defines are not taken from .config.  The .config file is processed
by the kernel configurator, which writes out the autoconf.h header.  It does
this by re-evaluating the contents of .config against all the Kconfig files.
It does not merely copy .config to autoconf.h.

In fact, if you try to write '2+3' into your .config, Kconfig will reject
it.  Eg:

.config:210:warning: symbol value '127+1' invalid for OMAP_32K_TIMER_HZ

and then it asks you to provide a valid value instead.

So yes, as pointed out, the parens are not required since Kconfig will
ensure that the symbol is a simple integer.
