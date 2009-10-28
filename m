From: rabin@rab.in (Rabin Vincent)
Date: Wed, 28 Oct 2009 21:09:16 +0530
Subject: smdk6400/S3C6400 failure on execution of init process
In-Reply-To: <20091028162037.22f2cb22@linpcd55>
References: <20091028162037.22f2cb22@linpcd55>
Message-ID: <20091028153916.GB2244@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2009 at 04:20:37PM +0100, Markus Schwarzenberg wrote:
> 
> booting linux-2.6.32-rc5 on our smdk6400 (S3C6400) fails somewhere in/after 
> the asm call in arch/arm/kernel/sys_arm.c:kernel_execve, when the init 
> process is to be run.
> 
> The preceding do_execve returned OK, which suggests that the /init file is 
> found, executable etc. in rootfs. 
> 
> The failure happens for both booting from  sd-card as well as from initramfs.
> I've tried several /init applications, from busybox to a simple wait(1); loop
> all with the same behavior.
> 
> What's the best way to debug this?

As a first step, enable CONFIG_DEBUG_USER in your kernel and pass
"user_debug=31" on the kernel command line.  You'll get more info about
why init's being killed.

Rabin
