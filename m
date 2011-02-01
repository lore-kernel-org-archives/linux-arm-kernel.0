From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 09:22:39 +0000
Subject: linux-next-20100201 - OMAP2+ defconfig broken with CONFIG_DEBUG_LL
In-Reply-To: <AANLkTinF+dpKvuRztChBM01MAjgL-foGp_yVq3uC9ghu@mail.gmail.com>
References: <AANLkTinF+dpKvuRztChBM01MAjgL-foGp_yVq3uC9ghu@mail.gmail.com>
Message-ID: <20110201092238.GA31015@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 11:09:52AM +0530, Gadiyar, Anand wrote:
> Hi all,
> 
> I tried to build linux-next as of 20100201 with omap2plus_defconfig. In addition
> I turned on CONFIG_DEBUG_LL and hit the following error.

No need to bisect.  Tony knows about it.  It's the OMAP debug code using
what was a macro in assembly, which becomes a C function with the dynamic
P2V patches.
