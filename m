From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Jan 2015 12:18:44 -0600
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param
 for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
 <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
 <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
Message-ID: <54C92804.5090806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2015 12:14 PM, Catalin Marinas wrote:
>> >So it looks like there's a whole conversation about this already in
>> >this thread that I didn't notice.  However, reading through all of it,
>> >I still don't understand sure why the presence of ACPI tables is
>> >insufficient to enable ACPI.

> Because ACPI on arm64 is still experimental, no matter how many people
> claim that it is production ready in their private setups.

Fair enough.  Does this mean that passing "acpi=force" on the kernel 
command line is a requirement for ARM64 servers?

>> >In what situation would we want to ignore ACPI tables that are
>> >present?

> When DT tables are also present (and for the first platforms, that's
> highly recommended, though not easily enforceable at the kernel level).

My understanding is that the EFI stub creates a device tree (and it 
contains some important information), so I don't understand how we can 
ever have an ACPI-only platform on ARM64 servers.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
