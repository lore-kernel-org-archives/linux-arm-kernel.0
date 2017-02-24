From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 24 Feb 2017 09:22:35 +0900
Subject: [PATCH v2 1/4] pinctrl: samsung: Fix the width of PINCFG_TYPE_DRV
 bitfields for Exynos5433
In-Reply-To: <CACRpkdbR3x14h38Gg7qpeWnswwD9qsS0zDUrrXCEJH-AdEB+cQ@mail.gmail.com>
References: <CGME20161230041426epcas1p1f827d3cee8b607d81e9921b412ddf301@epcas1p1.samsung.com>
 <20161230041421.24448-1-andi.shyti@samsung.com>
 <20161230041421.24448-2-andi.shyti@samsung.com>
 <CACRpkdbR3x14h38Gg7qpeWnswwD9qsS0zDUrrXCEJH-AdEB+cQ@mail.gmail.com>
Message-ID: <58AF7CCB.5070303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 2016? 12? 30? 22:28, Linus Walleij wrote:
> On Fri, Dec 30, 2016 at 5:14 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> 
>> From: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> This patch fixes the wrong width of PINCFG_TYPE_DRV bitfields for Exynos5433
>> because PINCFG_TYPE_DRV of Exynos5433 has 4bit fields in the *_DRV
>> registers. Usually, other Exynos have 2bit field for PINCFG_TYPE_DRV.
>>
>> Fixes: 3c5ecc9ed353 ("pinctrl: exynos: Add support for Exynos5433")
>> Cc: stable at vger.kernel.org
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Nominally I think you should sign this off too Andi, as you are in the delivery
> path.
> 
> Patch applied for fixes.

This patch was already merged on your git and then merge it on tovalds's git[1].
But, when I checked the latest drivers/pinctrl/samsung/pinctrl-exynos.c,
it doesn't contain the all codes of patch[1].
Maybe, I think that there was some merge conflict[2]. 

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/pinctrl/samsung/pinctrl-exynos.c?id=1259feddd0f83649d5c48d730c140b4f7f3fa288
[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/pinctrl/samsung/pinctrl-exynos.c?id=7f36f5d11cda050b118f76d774151427a18d15ef

So, How can we fix it? If you want to resend the new patch, I'll do.
To help you understand, I just added the diff on the below.

Best Regards,
Chanwoo Choi


diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index f9b49967f512..63e51b56a22a 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -1468,82 +1468,82 @@ static void exynos_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
 
 /* pin banks of exynos5433 pin-controller - ALIVE */
 static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
-       EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
-       EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
-       EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
-       EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
-       EXYNOS_PIN_BANK_EINTW_EXT(8, 0x020, "gpf1", 0x1004, 1),
-       EXYNOS_PIN_BANK_EINTW_EXT(4, 0x040, "gpf2", 0x1008, 1),
-       EXYNOS_PIN_BANK_EINTW_EXT(4, 0x060, "gpf3", 0x100c, 1),
-       EXYNOS_PIN_BANK_EINTW_EXT(8, 0x080, "gpf4", 0x1010, 1),
-       EXYNOS_PIN_BANK_EINTW_EXT(8, 0x0a0, "gpf5", 0x1014, 1),
+       EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
+       EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
+       EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
+       EXYNOS5433_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
+       EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x020, "gpf1", 0x1004, 1),
+       EXYNOS5433_PIN_BANK_EINTW_EXT(4, 0x040, "gpf2", 0x1008, 1),
+       EXYNOS5433_PIN_BANK_EINTW_EXT(4, 0x060, "gpf3", 0x100c, 1),
+       EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x080, "gpf4", 0x1010, 1),
+       EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x0a0, "gpf5", 0x1014, 1),
 };
 
 /* pin banks of exynos5433 pin-controller - AUD */
 static const struct samsung_pin_bank_data exynos5433_pin_banks1[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
-       EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+       EXYNOS5433_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
 
 /* pin banks of exynos5433 pin-controller - CPIF */
 static const struct samsung_pin_bank_data exynos5433_pin_banks2[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - eSE */
 static const struct samsung_pin_bank_data exynos5433_pin_banks3[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FINGER */
 static const struct samsung_pin_bank_data exynos5433_pin_banks4[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FSYS */
 static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
-       EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
-       EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
-       EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr1", 0x0c),
-       EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpr2", 0x10),
-       EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpr3", 0x14),
+       EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
+       EXYNOS5433_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
+       EXYNOS5433_PIN_BANK_EINTG(8, 0x060, "gpr1", 0x0c),
+       EXYNOS5433_PIN_BANK_EINTG(2, 0x080, "gpr2", 0x10),
+       EXYNOS5433_PIN_BANK_EINTG(8, 0x0a0, "gpr3", 0x14),
 };
 
 /* pin banks of exynos5433 pin-controller - IMEM */
 static const struct samsung_pin_bank_data exynos5433_pin_banks6[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - NFC */
 static const struct samsung_pin_bank_data exynos5433_pin_banks7[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - PERIC */
 static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
-       EXYNOS_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
-       EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
-       EXYNOS_PIN_BANK_EINTG(2, 0x060, "gpc1", 0x0c),
-       EXYNOS_PIN_BANK_EINTG(6, 0x080, "gpc2", 0x10),
-       EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpc3", 0x14),
-       EXYNOS_PIN_BANK_EINTG(2, 0x0c0, "gpg0", 0x18),
-       EXYNOS_PIN_BANK_EINTG(4, 0x0e0, "gpd0", 0x1c),
-       EXYNOS_PIN_BANK_EINTG(6, 0x100, "gpd1", 0x20),
-       EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpd2", 0x24),
-       EXYNOS_PIN_BANK_EINTG(5, 0x140, "gpd4", 0x28),
-       EXYNOS_PIN_BANK_EINTG(2, 0x160, "gpd8", 0x2c),
-       EXYNOS_PIN_BANK_EINTG(7, 0x180, "gpd6", 0x30),
-       EXYNOS_PIN_BANK_EINTG(3, 0x1a0, "gpd7", 0x34),
-       EXYNOS_PIN_BANK_EINTG(5, 0x1c0, "gpg1", 0x38),
-       EXYNOS_PIN_BANK_EINTG(2, 0x1e0, "gpg2", 0x3c),
-       EXYNOS_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
+       EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
+       EXYNOS5433_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
+       EXYNOS5433_PIN_BANK_EINTG(2, 0x060, "gpc1", 0x0c),
+       EXYNOS5433_PIN_BANK_EINTG(6, 0x080, "gpc2", 0x10),
+       EXYNOS5433_PIN_BANK_EINTG(8, 0x0a0, "gpc3", 0x14),
+       EXYNOS5433_PIN_BANK_EINTG(2, 0x0c0, "gpg0", 0x18),
+       EXYNOS5433_PIN_BANK_EINTG(4, 0x0e0, "gpd0", 0x1c),
+       EXYNOS5433_PIN_BANK_EINTG(6, 0x100, "gpd1", 0x20),
+       EXYNOS5433_PIN_BANK_EINTG(8, 0x120, "gpd2", 0x24),
+       EXYNOS5433_PIN_BANK_EINTG(5, 0x140, "gpd4", 0x28),
+       EXYNOS5433_PIN_BANK_EINTG(2, 0x160, "gpd8", 0x2c),
+       EXYNOS5433_PIN_BANK_EINTG(7, 0x180, "gpd6", 0x30),
+       EXYNOS5433_PIN_BANK_EINTG(3, 0x1a0, "gpd7", 0x34),
+       EXYNOS5433_PIN_BANK_EINTG(5, 0x1c0, "gpg1", 0x38),
+       EXYNOS5433_PIN_BANK_EINTG(2, 0x1e0, "gpg2", 0x3c),
+       EXYNOS5433_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
 };
 
 /* pin banks of exynos5433 pin-controller - TOUCH */
 static const struct samsung_pin_bank_data exynos5433_pin_banks9[] __initconst = {
-       EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
+       EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
 };
 
 /*
