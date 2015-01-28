From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Jan 2015 11:58:54 -0600
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 9:04 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> From: Al Stone <al.stone@linaro.org>
>
> Introduce one early parameters "off" and "force" for "acpi", acpi=off
> will be the default behavior for ARM64, so introduce acpi=force to
> enable ACPI on ARM64.
>
> Disable ACPI before early parameters parsed, and enable it to pass
> "acpi=force" if people want use ACPI on ARM64. This ensures DT be
> the prefer one if ACPI table and DT both are provided at this moment.

What is the reason to assume that DT is preferred over ACPI?  I would
have thought that if ACPI is present, then it means we're on an ARM64
server platform, and therefore it should be used.  It seems silly to
require acpi=force on every ARM64 server platform.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
