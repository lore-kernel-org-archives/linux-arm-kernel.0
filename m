From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Sep 2013 21:36:51 -0700
Subject: [PATCH v4] dt: update PSCI binding documentation for v0.2
In-Reply-To: <1379625868-5395-1-git-send-email-robherring2@gmail.com>
References: <1379625868-5395-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAOesGMjNhYTfPOr5NPEC9GWym-nuFE0hX_6+LW9bTv_E3iXbcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just a quick drive-by. Sorry, I don't know the history of previous
review cycles.


On Thu, Sep 19, 2013 at 2:24 PM, Rob Herring <robherring2@gmail.com> wrote:

>  Main node optional properties:
>
> - - cpu_suspend   : Function ID for CPU_SUSPEND operation
> + - cpu_suspend[-<32|64]   : Function ID for CPU_SUSPEND operation
> +
> + - cpu_off                : Function ID for CPU_OFF operation
> +
> + - cpu_on[-<32|64]        : Function ID for CPU_ON operation
> +
> + - affinity_info[-<32|64] : Function ID for AFFINITY_INFO operation
>
> - - cpu_off       : Function ID for CPU_OFF operation
> + - migrate[-<32|64]       : Function ID for MIGRATE operation
>
> - - cpu_on        : Function ID for CPU_ON operation
> + - migrate_info_type      : Function ID for MIGRATE_INFO_TYPE operation
>
> - - migrate       : Function ID for MIGRATE operation
> + - migrate_info_up_cpu[-<32|64] : Function ID for MIGRATE_INFO_UP_CPU operation
>
> + - system_reset           : Function ID for SYSTEM_RESET operation
> +
> + - system_off             : Function ID for SYSTEM_OFF operation

All of these should use dashes instead of underscores.

I also wonder if it would be better to move them into a subnode to
keep the namespace a bit cleaner.

> +Some functions have have separate IDs for 32-bit and 64-bit calling
> +conventions. These separate function IDs are described with function names with
> +"-64" and "-32" suffixes (e.g. cpu_on-64). Where a function name does not have
> +a suffix, the ID may be used with either calling convention depending on the
> +CPU state -- AArch32 callers should use the 32-bit calling convention, and
> +AArch64 callers should use the 64-bit calling convention.

Why not just make them a possible two-element property with <32 64>,
or if only one element, same on both? Seems cleaner.





-Olof
