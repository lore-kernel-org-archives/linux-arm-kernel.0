From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 11:03:28 +0000
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <CAMuHMdXvuwXps7j2jz18aB1VueLh5Vn0m94jLvBEO-CmsG1JxQ@mail.gmail.com>
References: <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205192605.GD29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051443190.2357@xanadu.home>
 <20111206093709.GB2274@linaro.org>
 <20111206104654.GN14542@n2100.arm.linux.org.uk>
 <CAMuHMdXvuwXps7j2jz18aB1VueLh5Vn0m94jLvBEO-CmsG1JxQ@mail.gmail.com>
Message-ID: <20111206110328.GP14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 12:00:12PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 6, 2011 at 11:46, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > But.. let's make one thing clear: Alan Cox and Linus have been going on
> > about how IRQ0 should not be used. ?Let's be crystal clear: even x86
> > uses IRQ0. ?It happens to be the PIC timer, and that gets claimed early
> > on during the x86 boot. ?So please don't tell me that x86 avoids IRQ0.
> > It doesn't. ?It just happens that x86 never shows IRQ0 to anything but
> > the i8253 PIC driver.
> 
> It's shown in /proc/interrupts due to a "bug" in show_interrupts().
> The (gmail damaged) patch below fixes this bug.

So we now try to hide the fact that there _is_ an interrupt called 0
on x86 systems?  Sorry, I can't that that seriously in any way.
