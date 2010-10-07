From: cwlinux.morgan@gmail.com (Morgan Howe)
Date: Thu, 7 Oct 2010 16:09:04 +0800
Subject: USB Mass Storage write problem
In-Reply-To: <20101001084948.GC5214@radix50.net>
References: <20101001160035.7c67e481@morgan>
	<20101001084948.GC5214@radix50.net>
Message-ID: <AANLkTinmjojFPYA5jzx9N=sztuucxBnQcQ2JwcTcTQhr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Baurzhan,

On Fri, Oct 1, 2010 at 4:49 PM, Baurzhan Ismagulov <ibr@radix50.net> wrote:

> On Fri, Oct 01, 2010 at 04:00:35PM +0800, Morgan Howe wrote:
> > Has anyone experienced anything like this or have some idea where to
> > look?
>
> I had a somewhat similar problem which turned out to be floating DMA
> control lines of the USB controller, which resulted in incorrect reads
> from and writes to the flash on the CPU bus.
>
> In your case, I'd disable all drivers that are not used in the test case
> and repeat the test.
>
> The next step could be tracing the lowest-level writing routine in the
> kernel in order to see whether it is called at all, gets the right data
> (e.g., you could generate a file that has the same checksum for every
> block written, etc.) and correctly handles status information from the
> hardware.
>

I appreciate you taking the time to provide such a helpful response.  It
definitely gave us some direction to start debugging this problem.  As it
turns out, we seem to have been able to resolve the problem with some
hardware rework.

Thanks and regards,
Morgan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101007/2848d009/attachment-0001.html>
