From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 22:49:00 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <50FDC2DD.7090406@linaro.org>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de> <50FDAC5F.4040605@linaro.org>
 <CAKGA1b=D5CNikijoOAk5xP6TC-nB_gEGtS05ncrPR68sQTMrxw@mail.gmail.com>
 <50FDC2DD.7090406@linaro.org>
Message-ID: <20130121224900.GB23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 02:36:13PM -0800, John Stultz wrote:
> Well, Russell brought up a case that doesn't handle this. If a system  
> *can't* do HZ=100, but can do HZ=200.
>
> Though there are hacks, of course, that might get around this (skip  
> every other interrupt at 200HZ).

Note: in the early days of EBSA110 support, yes, we did that, so that
we could have HZ=100 everywhere.  _However_ it sufficiently peturbed
NTP that it basically was unable to slew the clock in any sane manner.
I never got to the bottom of why that was, and when USER_HZ was
decoupled from the kernel HZ, it allowed the problem to be fixed, and
the kernel code to become a _lot_ cleaner.
