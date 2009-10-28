From: rabin@rab.in (Rabin Vincent)
Date: Wed, 28 Oct 2009 21:40:28 +0530
Subject: smdk6400/S3C6400 failure on execution of init process
In-Reply-To: <20091028165949.593b4d04@linpcd55>
References: <20091028162037.22f2cb22@linpcd55> <20091028153916.GB2244@debian>
	<20091028165949.593b4d04@linpcd55>
Message-ID: <20091028161028.GA2841@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2009 at 04:59:49PM +0100, Markus Schwarzenberg wrote:
> On Wed, 28 Oct 2009 21:09:16 +0530 Rabin Vincent <rabin@rab.in> wrote:
> 
> > On Wed, Oct 28, 2009 at 04:20:37PM +0100, Markus Schwarzenberg wrote:
> > > 
> > > booting linux-2.6.32-rc5 on our smdk6400 (S3C6400) fails somewhere in/after 
> > > the asm call in arch/arm/kernel/sys_arm.c:kernel_execve, when the init 
> > > process is to be run.
> > 
> > As a first step, enable CONFIG_DEBUG_USER in your kernel and pass
> > "user_debug=31" on the kernel command line.  You'll get more info about
> > why init's being killed.
> 
> thanks, did this, the additional messages are (context see [*]):
> 
>   [1] endless-loop-no: obsolete system call 00000000.
>   Code: e08f1001 e1a0c000 e3a0702d ef000000 (e3700a01) 

EABI-OABI mismatch.  Your userspace is EABI, but your kernel isn't.
Enable "Use the ARM EABI to compile the kernel" in "Kernel Features".

Also, re: your reply to Ben, you have to select one of the floating
point options, otherwise you'll have other such issues.

Rabin.
