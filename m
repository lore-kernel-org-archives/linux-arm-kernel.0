From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 8 Feb 2017 09:25:40 -0800
Subject: next-20170208 build: 1 failures 16 warnings (next-20170208)
In-Reply-To: <20170208172250.rnqxq7g77ekuo2pv@sirena.org.uk>
References: <E1cbPtA-00012m-9J@optimist>
 <20170208172250.rnqxq7g77ekuo2pv@sirena.org.uk>
Message-ID: <CAB=NE6X1WMByuARS4mZ1g9+W=LuVBnMDnh_5zyN0CLADaVh=Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 9:22 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Feb 08, 2017 at 10:54:16AM +0000, Build bot for Mark Brown wrote:
>
> Today's -next fails to build an arm64 allmodconfig due to:
>
>>       arm64-allmodconfig
>> ../arch/arm64/kernel/armv8_deprecated.c:359:31: error: expected '=',
>> ',', ';',
> +'asm' or '__attribute__' before 'aarch32_check_condition'
>> ../arch/arm64/kernel/armv8_deprecated.c:386:10: error: implicit
>> declaration of
> +function 'aarch32_check_condition'
> [-Werror=implicit-function-declaration]
>
> triggered by 1930faf201e83f6 (kprobes: move kprobe declarations to
> asm-generic/kprobes.h) according to a bisect, though I didn't
> immediately see how.

This fixes that, will send patch.

--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -19,6 +19,7 @@
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
+#include <asm/kprobes.h>
 #include <linux/uaccess.h>
 #include <asm/cpufeature.h>
