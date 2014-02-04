From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 4 Feb 2014 02:30:39 +0100
Subject: [GIT PULL] ARM: mvebu: stable fix for v3.13
In-Reply-To: <20140114154141.GO19878@titan.lakedaemon.net>
References: <20140114154141.GO19878@titan.lakedaemon.net>
Message-ID: <20140204013039.GA25262@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:41:41AM -0500, Jason Cooper wrote:
> arm-soc folks,
> 
> Sorry for the lateness in the window on this one.  I'd like to see it
> get into v3.13 if possible, but if it doesn't get there till v3.13.1, I
> understand.
> 
> This fixes a boot hang experienced on some Openblocks AX3-4 boards.
> Once i2c transaction support was added, it was discovered that the A0
> revision of the Armada XP had broken offload support which causes the
> kernel to hang at boot.  The only way to detect this situation is to
> read the PCI config register to get the SoC revision, then disable
> offload if we are on an A0 SoC.
> 
> Unfortunately, this makes for a rather large patch series against
> stable.  Doing the fix in a smaller patch would create a runtime
> dependency between i2c and PCI which we prefer to avoid.
> 
> I'm Cc'ing Greg and linux-stable as a heads-up, and so they can comment
> or ask questions.

It's a big change for stable, but as it's self-contained, and only
touches one platform/driver, I'll take it...

greg k-h
