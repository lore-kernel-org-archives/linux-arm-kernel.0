From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Oct 2017 15:25:18 +0000
Subject: [PATCH v2 10/10] arm+arm64: vdso: Add support for CLOCK_BOOTTIME
In-Reply-To: <20171012230154.87782-1-salyzyn@android.com>
References: <20171012230154.87782-1-salyzyn@android.com>
Message-ID: <20171030152517.GB1705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Oct 12, 2017 at 04:01:45PM -0700, Mark Salyzyn wrote:
> Add a case for CLOCK_BOOTTIME as it is popular for measuring
> relative time on systems expected to suspend() or hibernate().
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> 
> v2: rebased and changed from 3/3 to 10/10, fortified commit message.
> ---
>  arch/arm/include/asm/vdso_datapage.h   |  1 +
>  arch/arm/kernel/vdso.c                 |  1 +
>  arch/arm/vdso/vgettimeofday.c          | 56 ++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/vdso_datapage.h |  1 +
>  arch/arm64/kernel/vdso.c               |  1 +
>  5 files changed, 60 insertions(+)

Can you elaborate a bit on the use-case for CLOCK_BOOTTIME, please, so
that we can justify accelerating it in the vDSO?

Thanks,

Will
