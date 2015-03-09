From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 9 Mar 2015 19:33:15 +0100
Subject: [PATCH] ARM: at91: sama5d4: Properly configure L2CC
In-Reply-To: <20150309172337.GA8656@n2100.arm.linux.org.uk>
References: <1425468563-14300-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150309172337.GA8656@n2100.arm.linux.org.uk>
Message-ID: <20150309183315.GA9188@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2015 at 17:23:37 +0000, Russell King - ARM Linux wrote :
> On Wed, Mar 04, 2015 at 12:29:23PM +0100, Alexandre Belloni wrote:
> > As the bootloader may not properly configure the L2CC, enforce its configuration
> > in the kernel.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> And I assume you never bothered to read the kernel messages which result
> from this?  I guess this means I need to ensure that the kernel freezes
> if you do this kind of thing so you can't ignore the complaints from
> the L2C code.
> 
> It would be much better if you configured the L2C in the boot loader/
> board firmware rather than trying to have the kernel do it.
> 

As I understand, there is no proper way to enable prefetch from the
kernel so if it is not done by the bootloader or firmware (and it is
not), then we are out of luck.

Or is there something done right on berlin and exynos that I'm not doing
here?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
