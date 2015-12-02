From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 2 Dec 2015 16:20:41 +0000
Subject: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
In-Reply-To: <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
 <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBE1231@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yalin wang
> Sent: 30 November 2015 16:42
> > On Nov 27, 2015, at 19:09, Petr Mladek <pmladek@suse.com> wrote:
> >
> > Testing has shown that the backtrace sometimes does not fit
> > into the 4kB temporary buffer that is used in NMI context.
> >
> > The warnings are gone when I double the temporary buffer size.

You are wasting a lot of memory for something that is infrequently used.
There ought to be some way of copying partial tracebacks into the
main buffer.

	David
