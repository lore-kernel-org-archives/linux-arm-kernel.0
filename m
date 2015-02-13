From: zjzhang@codeaurora.org (Jonathan (Zhixiong) Zhang)
Date: Thu, 12 Feb 2015 16:50:33 -0800
Subject: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <a314cdbbefb349acbb8f47d6e806989f@NASANEXM01D.na.qualcomm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <a314cdbbefb349acbb8f47d6e806989f@NASANEXM01D.na.qualcomm.com>
Message-ID: <003301d04727$1390fcb0$3ab2f610$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2015 05:45 AM, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Two more documentation files are also being added:
> (1) A verbatim copy of the "Why ACPI on ARM?" blog posting by Grant
Likely,
>     which is also summarized in arm-acpi.txt, and
> 
> (2) A section by section review of the ACPI spec (acpi_object_usage.txt)
>     to note recommendations and prohibitions on the use of the numerous
>     ACPI tables and objects.  This sets out the current expectations of
>     the firmware by Linux very explicitly (or as explicitly as I can, for
>     now).
> 
[snip....]
> +ERST	Section 18.5 (signature == "ERST")
> +	== Error Record Serialization Table ==
> +	Must be supplied if RAS support is provided by the platform.  It
> +	is recommended this table be supplied.

The above text related to ERST table could lead to misunderstanding.
Following is what the ACPI spec (section 18.5) says:
"The error record serialization feature is used to save and retrieve
hardware error information to and from a persistent store. OSPM interacts
with the platform through a platform interface. On UEFI-based platforms, the
UEFI runtime variable services can be used to carry out error record
persistence operations. On non-UEFI based platforms, the ACPI solution
described below is used."

When RAS support is provided by the platform, ERST table may not be supplied
when it is UEFI-based and when UEFI run time service provides the ability to
save and retrieve hardware error information to and from a persistent store
(UEFI spec section 7.2.3). Therefore, following text might be more accurate:
" On a platform supports RAS, this table must be supplied if it is not
UEFI-based; if it is UEFI-based, this table may be supplied, consult your
firmware vendor if you are not sure. When this table is not present, UEFI
run time service will be utilized to save and retrieve hardware error
information to and from a persistent store."

====
Jonathan (Zhixiong) Zhang
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a
Linux Foundation Collaborative Project.
