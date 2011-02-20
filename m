From: dwalker@fifo99.com (Daniel Walker)
Date: Sat, 19 Feb 2011 18:26:57 -0800
Subject: [PATCH] msm: headsmp.S: Fix section mismatch
In-Reply-To: <1298085249-10518-1-git-send-email-sboyd@codeaurora.org>
References: <1298085249-10518-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1298168817.17118.2.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-18 at 19:14 -0800, Stephen Boyd wrote:
> WARNING: vmlinux.o(.cpuinit.text+0xc80): Section mismatch in
> reference from the function boot_secondary() to the variable
> .init.text:msm_secondary_startup
> The function __cpuinit boot_secondary() references a variable
> __init msm_secondary_startup.  If msm_secondary_startup is only
> used by boot_secondary then annotate msm_secondary_startup with
> a matching annotation.

Description is pretty gross.. Can you just explain how the section
mismatch is happening.

Daniel
