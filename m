From: mhowe@cwlinux.com (Morgan Howe)
Date: Fri, 18 Jun 2010 13:47:12 +0800
Subject: mxcmmc driver hangs on sync
In-Reply-To: <45DEC573-1158-477E-A971-03CB4633F442@zepcam.com>
References: <20100615112936.5d03ce92@morgan>
	<20100615063142.GU17833@buzzloop.caiaq.de>
	<20100615152051.26e4589c@morgan>
	<20100615072237.GW17833@buzzloop.caiaq.de>
	<20100617163340.69409a3f@morgan>
	<45DEC573-1158-477E-A971-03CB4633F442@zepcam.com>
Message-ID: <20100618134712.2d8d949f@morgan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Erik,

On Thu, 17 Jun 2010 20:51:37 +0200
Erik Oomen <erik.oomen@zepcam.com> wrote:
> We've had the same problems for various kernels and mxcmmc
> modifications. The following fixed it.  We applied it to the 2.6.28
> kernel and have been writing and reading *many* Gigabytes without a
> problem. 

We ran into this problem using 2 SD cards and assumed that it was
directly related to that.  This morning I decided to try and reproduce
this problem using only a single SD card, and I was indeed able to do
so.

Thanks for the patch - it does appear to fix the problem for a single
SD, but when using 2 SD cards I still ran into the issue.  However,
replacing your irq_save/restore calls with a spinlock seems to fix the
issue for multiple SD cards.  Is using a spinlock an appropriate way to
fix this or is there some other way that would be preferable?

Regards,
Morgan
