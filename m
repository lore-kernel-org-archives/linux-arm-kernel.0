From: seth.forshee@gmail.com (Seth Forshee)
Date: Tue, 3 Aug 2010 15:04:57 -0500
Subject: READ_IMPLIES_EXEC set when no GNU_STACK header present
In-Reply-To: <20100803200234.GB28048@n2100.arm.linux.org.uk>
References: <20100803195816.GB31111@ubuntu-workstation>
	<20100803200234.GB28048@n2100.arm.linux.org.uk>
Message-ID: <20100803200457.GC31111@ubuntu-workstation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 09:02:34PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 03, 2010 at 02:58:16PM -0500, Seth Forshee wrote:
> > We recently noticed that all of our applications had the execute
> > permission set for any mappings with read permission on an ARMv6
> > platform. This is happening because the ELF images do not have a
> > GNU_STACK program header, causing executable_stack=EXSTACK_DEFAULT to be
> > passed to arm_elf_read_implies_exec(), and it immediately returns 1.
> 
> That's correct behaviour.  Historically, ARM ELF binaries don't have
> the GNU_STACK program header, but expect read+exec behaviour from the
> stack.

Okay, thanks for the explanation.
