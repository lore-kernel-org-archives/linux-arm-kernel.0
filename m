From: tomasz.figa@gmail.com (tomasz.figa at gmail.com)
Date: Thu, 20 Dec 2012 22:06:27 +0100
Subject: [PATCH v2 3/3] ARM: EXYNOS5: save CLK_TOP_SRC3 register before
 powergating
In-Reply-To: <1356006378-17441-4-git-send-email-prasanna.ps@samsung.com>
References: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
 <1356006378-17441-4-git-send-email-prasanna.ps@samsung.com>
Message-ID: <21192551.mmsSZImfn7@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prasanna,

On Thursday 20 of December 2012 17:56:18 Prasanna Kumar wrote:
> This patch adds a software workaround to the hardware
> problem found in exynos5 while powergating.
> 
> It is observed that CLK_TOP_SRC3 register gets modified if
> the G-Scaler/MFC devices are power gated. The clock for G-Scaler gets
> set to XXTI which results in the device running very slow .
> A big drop in performance is noticed whilerunning the video.
> This issue also occurs while powergating MFC.
> 
> The value of clock source register is restored once the powergating
> operation is completed.

Is the problem really related to power gating at all? From what you 
described in comment in the code, it seems like it's a problem with 
suspend/resume, not power gating, so it should be rather saved on suspend 
and restored on resume. Please recheck clock save/restore part of power 
management code.

Altering clock configuration registers from power domain code looks really 
ugly...

Best regards,
Tomasz Figa
