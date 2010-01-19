From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 08:28:49 +0000
Subject: ioctl() returns EFAULT / MMU domain problem?
In-Reply-To: <ac4446ac1001182235m2efde18dl902c7ecc9fc6b100@mail.gmail.com>
References: <ac4446ac1001180535u299fa2f8rc2fdb3317a566066@mail.gmail.com>
	<20100118134723.GA2695@n2100.arm.linux.org.uk>
	<ac4446ac1001182235m2efde18dl902c7ecc9fc6b100@mail.gmail.com>
Message-ID: <20100119082849.GB23800@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 03:35:23PM +0900, Koyo Takenoshita wrote:
> > On context switches, the domain register is reloaded from cpu_domain,
> > so it will be preserved across context switches for the same thread;
> > if it wasn't, kernel boot wouldn't work (because the kernel boot uses
> > KERNEL_DS to be able to call execve(), open(), etc.)
> Would you please tell me where the context switch is done in kernel code?
> And, Is there any other point to change the domain register?

See __switch_to in arch/arm/kernel/entry-armv.S
