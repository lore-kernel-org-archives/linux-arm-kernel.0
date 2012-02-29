From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Feb 2012 00:06:09 +0000
Subject: [PATCH] ARM: mx51: Fix build error due to missing include of
 <linux/bug.h>
In-Reply-To: <20120228235244.GA3778@windriver.com>
References: <1330431110-22020-1-git-send-email-fabio.estevam@freescale.com>
 <20120228125336.GA3617@n2100.arm.linux.org.uk>
 <CAOMZO5ByrmWHYnahEm7PN=AxM2LygtytW5XRwUKMbngDUhKshA@mail.gmail.com>
 <20120228132108.GB3617@n2100.arm.linux.org.uk>
 <20120228235244.GA3778@windriver.com>
Message-ID: <20120229000609.GG18045@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 06:52:45PM -0500, Paul Gortmaker wrote:
> [Re: [PATCH] ARM: mx51: Fix build error due to missing include of <linux/bug.h>] On 28/02/2012 (Tue 13:21) Russell King - ARM Linux wrote:
> 
> [...]
> 
> > The answer is not to start scattering lots of .c files with linux/bug.h
> > includes, but to fix linux/kernel.h.
> 
> Hi Russell,
> 
> I understand your concerns, and had I found myself "buggering" lots
> of .c files, I would have backed away and said to myself, "OK, this
> really isn't going to work - we really can't do this."
> 
> But to put some metrics to it, after building for about 10 different
> arch and all their defconfigs, I only had to change about twenty[1] of
> the approximately sixteen thousand .c files in the kernel.

I think there's more than that - I've seen two reports for other
files which have needed fixing so far, and I wouldn't be surprised if
there's more.

I guess we'll see in coming weeks how it pans out, but my gut feeling
is that this is going to cause a fair number of build problems.
