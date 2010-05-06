From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 06 May 2010 14:51:48 +0100
Subject: cortex-m3 booting failure
In-Reply-To: <h2zec1f3d401005060330n22178e21ve22265bd37006825@mail.gmail.com>
References: <h2zec1f3d401005060330n22178e21ve22265bd37006825@mail.gmail.com>
Message-ID: <1273153908.2094.5.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-06 at 16:00 +0530, RK Raggit wrote:
> I am trying to boot the linux kernel with my baseport built on top of your
> architecture port (taken from this link
> http://www.linux-arm.org/LinuxKernel/LinuxM3) on
> my cortex-m3 based target FPGA.
> 
> kernel and busybox are compiled with the Sourcery G++ Lite 2009q3-66
> toolset and i
> am using an initramfs filesystem. My target has 4MB of RAM. I get the
> following bootlog -

I can't really tell what's happening but I'm going to release a new set
of patches against 2.6.33 sometime next week and there are some improved
error messages for Cortex-M3 support.

Do you have KALLSYMS enabled in the kernel?

> It looks like the first userspace process is crashing but i do not get
> any log (though
> i have user debug enabled). A few times though i do manage to get the
> serial console prompt
> but when i try to execute any simple command (like 'ls') then i see
> the same crash as above.

Have you tried with my variant of busybox from the above link?

Are you using the uclinux-eabi variant of the toolchain? Do you specify
-march=armv7-m and -mthumb options? If you link against the wrong C
library, it will fail.

> I am wondering what could be happening here.One possibility could be
> that busybox is not built
> properly but that seems less likely since i am using the standard
> code-sourcery toolchain.
> Could lack of memory be an issue ? ...but ~3.3MB seems good enough.

This should be ok.

-- 
Catalin
