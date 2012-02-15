From: davidb@codeaurora.org (David Brown)
Date: Wed, 15 Feb 2012 11:59:27 -0800
Subject: [PATCH] ARM: need to include asm/system.h in asm/processor.h
In-Reply-To: <1329333610-4474-1-git-send-email-olof@lixom.net>
References: <1329333610-4474-1-git-send-email-olof@lixom.net>
Message-ID: <20120215195927.GA31373@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 11:20:10AM -0800, Olof Johansson wrote:
> For files that include asm/processor.h but not asm/system.h:
> 
> arch/arm/mach-msm/include/mach/uncompress.h: In function 'putc':
> arch/arm/mach-msm/include/mach/uncompress.h:48:3: error: implicit declaration of function 'smp_mb' [-Werror=implicit-function-declaration]
> 
> In this case, smp_mb() is from the cpu_relax() call in the msm putc().
> 
> It likely went uncaught when the uncompress.h change went in since the
> defconfig didn't enable that code path, but later changes (e76f4750f4:
> ARM: debug: arrange Kconfig options more logically) resulted in the
> option being on for msm_defconfig and thus exposed it.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

BTW, Rob Herring has this same patch in his io.h cleanup patches, so
it's probably best to coordinate with him.

Author: Rob Herring <rob.herring@calxeda.com>
Date:   Mon Feb 13 15:43:15 2012 -0600

    ARM: add explicit include of system.h to processor.h
    
    cpu_relax in processor.h needs smp_mb which is defined in
    system.h.
    
    Signed-off-by: Rob Herring <rob.herring@calxeda.com>

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
