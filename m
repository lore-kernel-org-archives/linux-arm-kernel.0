From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sun, 16 Dec 2012 19:32:27 -0500
Subject: [PATCH v6] ARM: Factor out cpuid implementor and part number
In-Reply-To: <1354407686-38366-1-git-send-email-c.dall@virtualopensystems.com>
References: <1354407686-38366-1-git-send-email-c.dall@virtualopensystems.com>
Message-ID: <CANM98qKfFXmKwn24O1=5+f538qWKmRUCHHsXMyYi6hK5JKmvoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 1, 2012 at 7:21 PM, Christoffer Dall
<c.dall@virtualopensystems.com> wrote:
> Decoding the implementor and part number of the CPU id in the CPU ID
> register is needed by KVM, so we factor it out to share the code.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
> Changes since v5:
>  - (OK, this is getting ridiculous, this time I forgot a git add):
>    incorrect function declaration
> Changes since v4:
>  - Properly decode XScale cpu architecture versions
> Changes since v3:
>  - Only call read_cpuid_part_number once and squash warning
> Changes since v2:
>  - Take implementor as argument to read_cpuid_part_number
> Changes since v1:
>  - Accidentally pointed to an old file, this one has more consistent
>    naming of the cpu implementor and part number defines.
>
>  arch/arm/include/asm/cputype.h   |   33 +++++++++++++++++++++++++++++++++
>  arch/arm/kernel/perf_event_cpu.c |   34 ++++++++++++++++------------------
>  2 files changed, 49 insertions(+), 18 deletions(-)

any news on this one?

-Christoffer
