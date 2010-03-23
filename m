From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 20:53:42 +0000
Subject: [C/R ARM][PATCH 1/3] ARM: Rudimentary syscall interfaces
In-Reply-To: <1269219965-23923-2-git-send-email-christofferdall@christofferdall.dk>
References: <1269219965-23923-1-git-send-email-christofferdall@christofferdall.dk>
	<1269219965-23923-2-git-send-email-christofferdall@christofferdall.dk>
Message-ID: <20100323205342.GA19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 21, 2010 at 09:06:03PM -0400, Christoffer Dall wrote:
> This small commit introduces a global state of system calls for ARM
> making it possible for a debugger or checkpointing to gain information
> about another process' state with respect to system calls.

I don't particularly like the idea that we always store the syscall
number to memory for every system call, whether the stored version is
used or not.

Since ARM caches are generally not write allocate, this means mostly
write-only variables can have a higher than expected expense.

Is there not some thread flag which can be checked to see if we need to
store the syscall number?
