From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 24 Oct 2009 11:49:16 +0100
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <af3ea28a0910212035w5f44f108r594ced6062bb35f3@mail.gmail.com>
References: <1256123277.3851.36.camel@debian-nb>
	<af3ea28a0910212035w5f44f108r594ced6062bb35f3@mail.gmail.com>
Message-ID: <20091024104916.GB16451@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2009 at 11:35:22AM +0800, ye janboe wrote:
> hi,
> No one think that it is possible that put_user could fail in some
> situation even if currently kernel subtract 12 from ARM_sp and cross
> page bound?

It is possible, and it's something we should fix.  Note there's another
fix in this area (I've just posted) which will make your patch invalid.
Please wait until we've sorted out this other patch.
