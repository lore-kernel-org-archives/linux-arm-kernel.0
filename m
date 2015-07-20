From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 20 Jul 2015 07:12:06 -0500
Subject: [PATCH v3 2/8] ACPI / irqchip: Add self-probe
 infrastructure to initialize IRQ controller
In-Reply-To: <55ACC022.1000800@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>	<1436525114-14425-3-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXWB71tzc=OMm_UH23jc+_wsA5=pC5W9arrEM-URm_sywg@mail.gmail.com>
 <55ACC022.1000800@linaro.org>
Message-ID: <55ACE596.10709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hanjun Guo wrote:
>> Should we display an error message if we don't find a matching table?
>> That can happen if the ACPI tables shows a GIC version number that is
>> not listed in __irqchip_acpi_table[]?
>
> Hmm, did you get the error message like: "Invalid GIC version 5 in
> MADT"? or just use ACPI_MADT_GIC_VERSION_V1 as the gic_version? if
> the later one, it will show everything is fine, but failed to probe
> the GIC.

We had a bug in our ACPI tables that listed the GIC version as 1, and it 
failed to probe and then the kernel panicked.  It took me a while to 
figure out what was wrong, so I think it should print an error message 
that says that version X is unsupported.


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
