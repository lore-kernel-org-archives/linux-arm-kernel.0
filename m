From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 28 Feb 2012 18:52:45 -0500
Subject: [PATCH] ARM: mx51: Fix build error due to missing include of
 <linux/bug.h>
In-Reply-To: <20120228132108.GB3617@n2100.arm.linux.org.uk>
References: <1330431110-22020-1-git-send-email-fabio.estevam@freescale.com>
 <20120228125336.GA3617@n2100.arm.linux.org.uk>
 <CAOMZO5ByrmWHYnahEm7PN=AxM2LygtytW5XRwUKMbngDUhKshA@mail.gmail.com>
 <20120228132108.GB3617@n2100.arm.linux.org.uk>
Message-ID: <20120228235244.GA3778@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH] ARM: mx51: Fix build error due to missing include of <linux/bug.h>] On 28/02/2012 (Tue 13:21) Russell King - ARM Linux wrote:

[...]

> The answer is not to start scattering lots of .c files with linux/bug.h
> includes, but to fix linux/kernel.h.

Hi Russell,

I understand your concerns, and had I found myself "buggering" lots
of .c files, I would have backed away and said to myself, "OK, this
really isn't going to work - we really can't do this."

But to put some metrics to it, after building for about 10 different
arch and all their defconfigs, I only had to change about twenty[1] of
the approximately sixteen thousand .c files in the kernel.  That is
about 0.125% -- which is one of the things that made me think "Hey, we
can really do this cleanup!"   Including this file, there were only
two .c files in all of arch/arm that were using bug somehow.

So I think having kernel.h not require bug.h is completely do-able.
But in the end, I'm not welded to the idea.  I think it is a win, but
I'm not going to kick up a big stink if Linus or Andrew say they don't
think it is of value, and would rather not rock the boat.

Thanks,
Paul.
--

[1] https://lkml.org/lkml/2012/1/26/521
