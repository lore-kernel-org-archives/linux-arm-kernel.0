From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jun 2014 15:40:46 +0100
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140630144045.GM25779@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

On Mon, Jun 23, 2014 at 04:11:49AM +0100, Nathan Lynch wrote:
> Provide fast userspace implementations of gettimeofday and
> clock_gettime on systems that implement the generic timers extension
> defined in ARMv7.  This follows the example of arm64 in conception but
> significantly differs in some aspects of the implementation (C vs
> assembly, mainly).

[...]

This series is starting to gain traction now, so it's probably time to start
thinking about implementing this for CONFIG_COMPAT on arm64. We currently
map a fake vectors page there, but this would be much more flexible,
particularly as its written in C (and so we would magically get any new
functions added to the 32-bit version).

So, there are a couple of questions that spring to mind:

  - How difficult is it to share the vdso code with arm64 to build a compat
    vdso? (getting the Makefile to work will be hard, as we'll need an arm
    toolchain...).

  - If we use your code to build an arm64 vdso, how much slower is it than
    the handcrafted asm we currently have?

Will
