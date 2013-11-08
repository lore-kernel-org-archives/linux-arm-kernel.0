From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Nov 2013 14:34:56 +0000
Subject: [PATCH 0/4] arm64: Add audit support
In-Reply-To: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20131108143456.GJ17461@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:25:42AM +0000, AKASHI Takahiro wrote:
> This patchset adds audit support on arm64.
> The implementation is just like in other architectures,
> and so I think little explanation is needed.

That doesn't mean you can just omit the commit messages!

> I'd like to discuss about the following issues:
> (issues)
> * AUDIT_ARCH_*
>   Why do we need to distiguish big-endian and little-endian? [2/4]

We don't. This is only the case if the syscall ABIs differ between them (for
AArch32, people mistakenly thought __ARMEB__ was related to AEABI.

> * Userspace audit package
>   There are some missing syscall definitions in lib/aarch64_table.h.
>   There is no support for AUDIT_ARCH_ARM (I mean LE. armeb is BE).

I did post something over a year ago... did it not get picked up?

  http://permalink.gmane.org/gmane.linux.ports.arm.kernel/165266

Will
