From: orenl@cs.columbia.edu (Oren Laadan)
Date: Sun, 20 Jun 2010 17:34:10 -0400
Subject: [C/R ARM v2][PATCH 0/3] Linux Checkpoint-Restart - ARM port
In-Reply-To: <1272318223-28438-1-git-send-email-christofferdall@christofferdall.dk>
References: <1272318223-28438-1-git-send-email-christofferdall@christofferdall.dk>
Message-ID: <4C1E8952.7010503@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applied.

On 04/26/2010 05:43 PM, Christoffer Dall wrote:
> Following there will be two preparatory patches for an ARM port of the
> checkpoint-restart code and finally a third patch implementing the
> architecture-specific parts of c/r.
> 
> The preparatory patches consist of a partial syscall trace implementation
> for ARM and an eclone implementation for ARM. The syscall trace
> implementation provides only the needed functionality for c/r.
> 
> There is a separate patch for the user space code, which supports
> cross-compilation, extracting headers for ARM and an eclone implementation
> for ARM.
> 
> The kernel patches presented here are based on the ckpt-v21-rc6 patch set.
> 
> ---
> 
> CHANGELOG:
> 
> [2010-Apr-08] v2:
> 	- Systrace implementation now inspects process state to get the
> 	  system call number thereby avoiding extra work on system calls.
> 	- Removed __user attribute on long type in eclone implementation
> 	- Better check for architecture versions across C/R
> 	- Improved checking of user space ABI settings across C/R
> 	- Code simplifications
> 
> [2010-Mar-22] v1:
> 	- Initial version
> 	- Systrace implementation modified the system call entry path to
> 	  store the system call number globally in memory.
> 	- ARM implementation lightly tested
> _______________________________________________
> Containers mailing list
> Containers at lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/containers
> 
