From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 07 Apr 2011 10:57:28 -0700
Subject: [PATCH v3] ARM: Use generic BUG() handler
In-Reply-To: <1302131890-20953-1-git-send-email-sjg@chromium.org>
References: <1302131890-20953-1-git-send-email-sjg@chromium.org>
Message-ID: <4D9DFB08.8090206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2011 04:18 PM, Simon Glass wrote:
> From: Simon Glass <sjg@google.com>
>
> ARM uses its own BUG() handler which makes its output slightly different
> from other archtectures.
>
[snip]
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/Kconfig              |    4 +++
>  arch/arm/include/asm/bug.h    |   55 ++++++++++++++++++++++++++++++++++------
>  arch/arm/kernel/traps.c       |   23 +++++++++++++++++
>  arch/arm/kernel/vmlinux.lds.S |    3 +-
>  4 files changed, 75 insertions(+), 10 deletions(-)

Also, have you tried this with a module? I think you would at least need
to modify arch/arm/kernel/module.c to hook up the module_bug_finalize()
and module_bug_cleanup() stuff.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
