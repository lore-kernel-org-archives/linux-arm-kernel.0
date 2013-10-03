From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Oct 2013 17:13:33 +0100
Subject: [PATCH v2 0/3] arm, arm64: check for number of arguments in
 syscall_get/set_arguments()
In-Reply-To: <1380779266-11753-1-git-send-email-takahiro.akashi@linaro.org>
References: <1380605584-22125-git-send-email-takahiro.akashi@linaro.org>
 <1380779266-11753-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20131003161333.GA7408@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 06:47:43AM +0100, AKASHI Takahiro wrote:
> # added Roland <mcgrathr@chromium> in CC for asm-generic/syscall.h
> 
> I modified my patch based on Will's comments.
> Speaking of arm, i + n is checked against SYSCALL_MAX_ARGS (== 7),
> but it seems that the kernel code assumes that the current max number of
> arguments would be 6. For example, SYSCALL_DEFINEn are defined from 0 to 6.
> Am i wrong?

We do have a 7 argument syscall on OABI ARM. See the original thread:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/085509.html

Will
