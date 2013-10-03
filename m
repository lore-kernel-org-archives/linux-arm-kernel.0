From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  3 Oct 2013 14:47:43 +0900
Subject: [PATCH v2 0/3] arm,
 arm64: check for number of arguments in syscall_get/set_arguments()
In-Reply-To: <1380605584-22125-git-send-email-takahiro.akashi@linaro.org>
References: <1380605584-22125-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1380779266-11753-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

# added Roland <mcgrathr@chromium> in CC for asm-generic/syscall.h

I modified my patch based on Will's comments.
Speaking of arm, i + n is checked against SYSCALL_MAX_ARGS (== 7),
but it seems that the kernel code assumes that the current max number of
arguments would be 6. For example, SYSCALL_DEFINEn are defined from 0 to 6.
Am i wrong?

Changes:
  * added a patch to arm as well
  * added a patch to asm-generic/syscall.h; corrected the description on
    syscall_get_arguments() and syscall_put_arguments()
  * removed portion of commit message which referred to asm-generic/syscall.h
    in arm64

AKASHI Takahiro (3):
  arm64: check for number of arguments in syscall_get/set_arguments()
  arm: check for number of arguments in syscall_get/set_arguments()
  asm-generic: syscall_get/set_arguments accept zero for number of
    arguments

 arch/arm/include/asm/syscall.h   |    6 ++++++
 arch/arm64/include/asm/syscall.h |    6 ++++++
 include/asm-generic/syscall.h    |    4 ++--
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.7.9.5
