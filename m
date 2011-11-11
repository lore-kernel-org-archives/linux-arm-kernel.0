From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Nov 2011 19:00:14 +0000
Subject: [PATCH 39/41] ARM: restart: lpc32xx & u300: remove unnecessary
 printk
In-Reply-To: <CACRpkda9mC6+WrbGekJD85X4t7AsuamhP5V=YcyNQLFw0Yii7A@mail.gmail.com>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6u6-0001ZD-Ll@rmk-PC.arm.linux.org.uk>
 <CACRpkda9mC6+WrbGekJD85X4t7AsuamhP5V=YcyNQLFw0Yii7A@mail.gmail.com>
Message-ID: <20111111190014.GB4154@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 07:46:41PM +0100, Linus Walleij wrote:
> On Sun, Nov 6, 2011 at 6:53 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Remove the:
> > ? ? ? ?KERN_CRIT "RESET: Rebooting system\n" (lpc32xx)
> > ? ? ? ?KERN_CRIT "RESET: shutting down/rebooting system\n" (u300)
> >
> > printk from the restart handler; we already print such a message from
> > kernel_restart() in kernel/sys.c:
> >
> > ? ? ? ?KERN_EMERG "Restarting system.\n"
> >
> > so this is unnecessary.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.  Could you look at what's required for Nomadik please?  I couldn't
see am obvious file to move the arch_reset code from mach/system.h into,
nor could I see a local header file to put the new prototype into.
