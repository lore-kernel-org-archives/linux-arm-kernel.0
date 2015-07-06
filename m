From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jul 2015 22:35:35 +0100
Subject: weird behavior of get/set_fiq_regs()
In-Reply-To: <CAOpc7mE5oJFzHXH2bOGRnEDfQ3Go-QpROSZ7KJeTsPxG0ibqZw@mail.gmail.com>
References: <CAOpc7mHkynAfmZKJhbwF0q0rco+3t7=wzh9owf6Brz6fmPRHsw@mail.gmail.com>
 <20150706160230.GG7557@n2100.arm.linux.org.uk>
 <CAOpc7mE5oJFzHXH2bOGRnEDfQ3Go-QpROSZ7KJeTsPxG0ibqZw@mail.gmail.com>
Message-ID: <20150706213535.GH7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 11:04:45PM +0200, Holger Schurig wrote:
> Why?  I was under the impression that the assembly code from my *.S
> routine get's copied directly after the exception vectors. Why would
> it matter if the bytes between myfiq_start and myfiq_end come from a
> module or from somewhere else?

By "FIQ handlers in module code", I mean executing them in module code.
Using the provided function to copy the code out of the module means
that any problems associated with lazy page table propagation are
avoided.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
