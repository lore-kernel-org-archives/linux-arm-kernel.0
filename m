From: david.brown@linaro.org (David Brown)
Date: Fri, 9 Sep 2016 17:40:48 -0600
Subject: [kernel-hardening] [PATCH v2 0/7] arm64: Privileged Access Never
 using TTBR0_EL1 switching
In-Reply-To: <1472828533-28197-1-git-send-email-catalin.marinas@arm.com>
References: <1472828533-28197-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160909234048.GA9803@davidb.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 04:02:06PM +0100, Catalin Marinas wrote:
>This is the second version of the arm64 PAN emulation by disabling
>TTBR0_EL1 accesses. The major change from v1 is the use of a thread_info
>member to store the real TTBR0_EL1 value. The advantage is slightly
>simpler assembler macros for uaccess_enable with the downside that
>switch_mm() must always update the saved ttbr0 even if there is no mm
>switch.

I seem to have a lot better results with this series than I was having
with v1.  I've tested this both within qemu, and on the HiKey board
and with OP-TEE (to make sure it didn't break anything), and
everything seems to be working.

Tested-by: David Brown <david.brown@linaro.org>
