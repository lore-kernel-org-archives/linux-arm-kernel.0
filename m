From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 20 Mar 2014 12:34:46 +0000
Subject: arm64: mainline with foundation model: hang in arm64_device_init
In-Reply-To: <7h7g7pen2c.fsf@paris.lan>
References: <7h7g7pen2c.fsf@paris.lan>
Message-ID: <532AE066.5010809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 20/03/14 00:22, Kevin Hilman wrote:
> Hi Catalin,
>
> Should I expect vanilla mainline (v3.14-rc7) to work with the current
> aarch64 foundation model r0p0 (model build 0.8.5206)?  I'm also using
> the master branch of your boot-wrapper-aarch64 configured to point at
> the mainline tree.
>
> I've gotten as far as adding initcall_debug to the cmdline and noticing
> that arm64_device_init never returns, but have to call it a day so have
> to wait til tomorrow to debug further.  In the mean time wanted to check
> with you on whether it should work.
>

This is not due to any kernel bug, but due to bootwrapper picking up wrong 
device tree. I will work on fixing it in the boot-wrapper-aarch64 repo.

Meanwhile could change KERN_DTB in configure.ac to point to foundation-v8.dtb 
and give it a try.

Regards,
Sudeep
