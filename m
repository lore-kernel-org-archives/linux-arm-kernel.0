From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 11 Mar 2014 22:02:26 -0400
Subject: [PATCH v5 0/7] arm64: Add ftrace support
In-Reply-To: <531FBCA8.2080805@linaro.org>
References: <1393320196-2942-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
 <20140311143535.GE7944@mudshark.cambridge.arm.com>
 <531FBCA8.2080805@linaro.org>
Message-ID: <20140311220226.452632a6@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Mar 2014 10:47:20 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:


> This happens when a header file, elf.h, on "your host machine" does not have
> definitions of EM_AARCH64 nor R_AARCH64_ABS64 because "recordmcount" is a binary
> utility on host(x86), not target. It is very likely for most distros.
> (I mentioned this in the cover letter, but the description might not be clear.)
> 
> Possible solutions are:
> 1) Define both macros directly in scripts/recordmcount.c
> 2) Use perl version of recordmcount
> 
> Currently I take 1), but it is a workaround.
> 2) should work with my current patch, too. But you need to remove HAVE_C_RECORDCOUNT
> from arm64/Kconfig.
> 
> Which one do you prefer? I will include a fix for 1) in the next revision, anyway.

Or even option 3)

3) I can update the main Makefile to check to see if EM_<ARCH> exists
in the elf.h header, and if not, we use the perl version and undef
HAVE_C_RECORDMCOUNT.

-- Steve
