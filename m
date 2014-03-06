From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Mar 2014 15:24:58 +0000
Subject: [PATCH v2 2/3] arm64: Add seccomp support
In-Reply-To: <5317DEC6.4060103@linaro.org>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320025-2855-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320025-2855-3-git-send-email-takahiro.akashi@linaro.org>
 <20140228172006.GF30996@mudshark.cambridge.arm.com>
 <5317DEC6.4060103@linaro.org>
Message-ID: <20140306152458.GG5202@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 02:34:46AM +0000, AKASHI Takahiro wrote:
> On 03/01/2014 02:20 AM, Will Deacon wrote:
> > On Tue, Feb 25, 2014 at 09:20:24AM +0000, AKASHI Takahiro wrote:
> > I'm slightly surprised that we do the secure computing check first. Doesn't
> > this allow a debugger to change the syscall to something else after we've
> > decided that it's ok?
> 
> To be honest, I just followed other architectures' implementation.
> Can you elaborate any use case that you have in your mind?

My initial thought was that we should do the secure_computing check *after*
the debugger has finished messing around with the registers. However, I
suppose you'd have had to enable ptrace in your seccompd filter for that
scenario to occur, so there's probably not an issue here after all.

Will
