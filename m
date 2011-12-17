From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Dec 2011 10:57:37 +0000
Subject: [PATCH] ARM: Fix cross compilation broken by failing size command
In-Reply-To: <1324032146-723-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <20111214215815.GP32251@atomide.com>
 <1324032146-723-1-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20111217105737.GO14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 11:42:26AM +0100, Janusz Krzysztofik wrote:
> Unfortunately, I've already pushed that old version to the patch system
> at http://www.arm.linux.org.uk/developer/patches/, which I know is not
> a review system. Apparently, I was not patient enough, not waiting more
> than a week with that regression fix for a single reply to my initial

I'll disagree with you there: this is not a regression fix.  A regression
fix implies that it was something that worked before, a change happened
to the kernel, and now it's broken.

That is not the case: a change happened to binutils which meant 'size'
no longer parses foreign ELF formats.  This is not a change to the
kernel, and therefore it is not a kernel regression.

Therefore, I consider it lower priority than true kernel regression
fixes, and also lower priority than normal bug fixes to the kernel:
it's actually a feature change - changing the kernel to work with a
new toolchain.

Since the original proposed change causes _me_ problems (I'm missing
an arm-linux-size for some unknown reason - which I've yet to resolve
one way or other) I've not yet considered the change any further than
noting that fact.

If it turns out that older versions of binutils do not supply a 'size'
command, then we need something like your v2 patch.  If it's the case
that for some reason it never got transferred when I changed machines,
then your v1 patch is appropriate and I need to fix that.  But that
requires investigation on my side, and I've not been able to do that
yet.
