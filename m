From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 8 Jun 2011 23:13:52 +0900
Subject: [PATCH] ARM: S5PV210: Fix build breakage due to renaming of
	S3C_VA_USB_HSPHY
In-Reply-To: <005501cc25e3$7df601e0$79e205a0$%szyprowski@samsung.com>
References: <1307532337-29348-1-git-send-email-thomas.ab@samsung.com>
	<005501cc25e3$7df601e0$79e205a0$%szyprowski@samsung.com>
Message-ID: <BANLkTi=c1p7yxswvymBWS1PQeqW=+weKbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2011 at 10:53 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> There is already the patch that fixes this issue available on
> kgene/s5p_fixes_for_linus branch. Please check commit 08115a139 from
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>
> On Wednesday, June 08, 2011 1:26 PM Thomas Abraham wrote:
>
>> Commit 8f1d169f999fea892c3fcbf5a79ae8525a477572
>> ("ARM: EXYNOS4: Add usb host phy control") renamed S3C_VA_USB_HSPHY
>> to S5P_VA_USB_HSPHY in s5p-map.h file. Fix build for S5PV210 platform.

Hi Thomas & Marek,

We lived for long time with mismatch prefix.
So how about to clean up the mismatch prefix, S3C_* and S5P_* at this time?

One method is that it just passes the physical address and driver
should ioremap at driver instead of static mapping.

How do you think?

Thank you,
Kyungmin Park

>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/cpu.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
>> index 61e6c24..b343582 100644
>> --- a/arch/arm/mach-s5pv210/cpu.c
>> +++ b/arch/arm/mach-s5pv210/cpu.c
>> @@ -91,7 +91,7 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
>> ? ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
>> ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> ? ? ? }, {
>> - ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S3C_VA_USB_HSPHY,
>> + ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_USB_HSPHY,
>> ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?=__phys_to_pfn(S5PV210_PA_HSPHY),
>> ? ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
>> ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> --
>> 1.6.6.rc2
>
> S3C_VA_USB_HSPHY is the correct name, it is also used on s3c64xx and
> s3c-hsotg driver (see drivers/usb/gadget).
>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
