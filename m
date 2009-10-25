From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Oct 2009 15:44:16 +0000
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <af3ea28a0910242323n55e14391x7519ecfb9de44856@mail.gmail.com>
References: <1256123277.3851.36.camel@debian-nb>
	<af3ea28a0910212035w5f44f108r594ced6062bb35f3@mail.gmail.com>
	<20091024104916.GB16451@n2100.arm.linux.org.uk>
	<af3ea28a0910242323n55e14391x7519ecfb9de44856@mail.gmail.com>
Message-ID: <20091025154416.GB1774@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2009 at 02:23:09PM +0800, ye janboe wrote:
> hi, Russell
> 
> Your patch looks good for real fixing this issue.

My patch doesn't address your issue, it only addresses a previous
problem.  We're still decrementing the stack pointer and writing to
a possible new page - which could fault.

Therefore, your patch is still required, but it needs to be modified
to apply on top of my patch.

A replacement patch would be welcome.
