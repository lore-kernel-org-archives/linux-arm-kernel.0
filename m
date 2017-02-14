From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 14 Feb 2017 09:24:15 -0600
Subject: [PATCH 1/2] Fix mmdc_pmu_write_accesses event definition
In-Reply-To: <1487062873-27641-2-git-send-email-andrei-tiberiu.breana@nxp.com>
References: <1487062873-27641-1-git-send-email-andrei-tiberiu.breana@nxp.com>
 <1487062873-27641-2-git-send-email-andrei-tiberiu.breana@nxp.com>
Message-ID: <CAHrpEqQh9vTmiLdrDHsOeuJ37Kq2PUGEdO=t6RZkjMMpMRhbJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject should add prefix like:

ARM: imx: fix xxxx

best regards
Frank Li

On Tue, Feb 14, 2017 at 3:01 AM, Tiberiu Breana
<andrei-tiberiu.breana@nxp.com> wrote:
> Fixed an error in the "write-accesses" event definition.
>
> Signed-off-by: Tiberiu Breana <andrei-tiberiu.breana@nxp.com>
> ---
>  arch/arm/mach-imx/mmdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index c03bf28..89a926f 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -87,7 +87,7 @@ static DEFINE_IDA(mmdc_ida);
>  PMU_EVENT_ATTR_STRING(total-cycles, mmdc_pmu_total_cycles, "event=0x00")
>  PMU_EVENT_ATTR_STRING(busy-cycles, mmdc_pmu_busy_cycles, "event=0x01")
>  PMU_EVENT_ATTR_STRING(read-accesses, mmdc_pmu_read_accesses, "event=0x02")
> -PMU_EVENT_ATTR_STRING(write-accesses, mmdc_pmu_write_accesses, "config=0x03")
> +PMU_EVENT_ATTR_STRING(write-accesses, mmdc_pmu_write_accesses, "event=0x03")
>  PMU_EVENT_ATTR_STRING(read-bytes, mmdc_pmu_read_bytes, "event=0x04")
>  PMU_EVENT_ATTR_STRING(read-bytes.unit, mmdc_pmu_read_bytes_unit, "MB");
>  PMU_EVENT_ATTR_STRING(read-bytes.scale, mmdc_pmu_read_bytes_scale, "0.000001");
> --
> 2.7.4
>
