From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Jun 2010 21:01:52 +0100
Subject: Possible methods for the kernel to terminate a process
In-Reply-To: <BAY134-W142753895B5626C329E273BDC40@phx.gbl>
References: <BAY134-W142753895B5626C329E273BDC40@phx.gbl>
Message-ID: <20100622200152.GA7325@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 22, 2010 at 03:40:35PM -0400, Xiachen Dong wrote:
> We have such question because we try to kill a user space process by the
> shell command kill and we cannot kill it probably because it is in an
> un-interruptible sleep/wait. 

Some applications block some signals while they wait for events.
SIGKILL is one signal which is unblockable.  Have you tried using
this rather than SIGTERM ?

> However, we still wish to be able to kill the user space process under
> this circumstance. To our knowledge of the kernel, if the kernel wants
> to kill a process when special event such as exception happens, it
> usually sends a signal to the process. We really cannot think of any
> other methods for a kernel to terminate a process.

Sometimes the kernel forcefully exits the task - but that can only happen
while the task's context is running.  If it's in an uninterruptible wait
then it won't be running.
