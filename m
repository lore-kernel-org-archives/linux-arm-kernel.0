From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Sep 2011 11:16:23 +0100
Subject: Kernel panic in 2.6.35.12 kernel
In-Reply-To: <CAJ8eaTyaiFzAnKB-P9EJT5UxxmpgTpw=Yk_Ee8qJUVKFjfHtKQ@mail.gmail.com>
References: <CAJ8eaTyeQj5_EAsCFDMmDs3faiVptuccmq3VJLjG-QnYG038=A@mail.gmail.com>
	<CAJ8eaTw=dKUNE8h-HD7RWxXHcTEuxJH4AfcOO44RSF7QdC5arQ@mail.gmail.com>
	<CAJ8eaTyaiFzAnKB-P9EJT5UxxmpgTpw=Yk_Ee8qJUVKFjfHtKQ@mail.gmail.com>
Message-ID: <20110901101623.GB29729@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 12:08:12PM +0530, naveen yadav wrote:
> adding to mm mailing list

I think rather than just adding a mailing list to a message containing
almost no useful content, you may do better to start a new thread
including the linux-mm mailing list, describing the problem that you're
seeing, the kernel messages plus the test program all in a single
message.

I don't think the problem you're reporting is ARM specific - to me it
looks like something is holding on to processes pages after they've
been killed, and only giving them back after the OOM killer has killed
off the last killable task.  That's certainly what the "xxx free pages"
values hint at.
