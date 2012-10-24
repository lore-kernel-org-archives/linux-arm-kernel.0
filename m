From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Oct 2012 20:30:09 +0000
Subject: [PATCH 2/2] arm: mvebu: Add hardware I/O Coherency support
In-Reply-To: <5087F38B.1010508@free-electrons.com>
References: <1351065841-18654-1-git-send-email-gregory.clement@free-electrons.com>
 <201210241224.06791.arnd@arndb.de> <5087F38B.1010508@free-electrons.com>
Message-ID: <201210242030.09959.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Gregory CLEMENT wrote:
> > No, I was thinking of making the underlying functions globally visible
> > and have extern declarations in a header file so you can access them
> > directly.
> > 
> > Generally speaking, when you run into a problem with common code, your
> > first approach should be to fix the common code before you try to work
> > around it.
> 
> OK I thought it was done on purpose. But if you consider it needs to be
> fixed I will add patch for it in next version.

As long as the functions were only used locally in one file, it's
better not to make them globally visible as a rule. But if we know
that they are needed, that should be made explicit. Please fix this
by submitting another patch to make those functions global and then
rebase this series on top of that.

	Arnd
