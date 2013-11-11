From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 11 Nov 2013 15:48:02 +0900
Subject: [PATCH 2/4] arm64: Add audit support
In-Reply-To: <20131108144307.GK17461@mudshark.cambridge.arm.com>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <1383733546-2846-3-git-send-email-takahiro.akashi@linaro.org>
 <20131108144307.GK17461@mudshark.cambridge.arm.com>
Message-ID: <52807DA2.4030704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 11:43 PM, Will Deacon wrote:
> On Wed, Nov 06, 2013 at 10:25:44AM +0000, AKASHI Takahiro wrote:
>> diff --git a/arch/arm64/kernel/audit.c b/arch/arm64/kernel/audit.c
>> new file mode 100644
>> index 0000000..9aab2b3
>> --- /dev/null
>> +++ b/arch/arm64/kernel/audit.c
>> @@ -0,0 +1,59 @@
>> +#include <linux/audit.h>
>> +#include <linux/init.h>
>> +#include <asm/unistd.h>
>> +
>> +static unsigned dir_class[] = {
>> +#include <asm-generic/audit_dir_write.h>
>> +~0U
>> +};
>> +
>> +static unsigned read_class[] = {
>> +#include <asm-generic/audit_read.h>
>> +~0U
>> +};
>> +
>> +static unsigned write_class[] = {
>> +#include <asm-generic/audit_write.h>
>> +~0U
>> +};
>> +
>> +static unsigned chattr_class[] = {
>> +#include <asm-generic/audit_change_attr.h>
>> +~0U
>> +};
>> +
>> +static unsigned signal_class[] = {
>> +#include <asm-generic/audit_signal.h>
>> +~0U
>> +};
>
> This looks like a copy of lib/audit.c to me. Why can't we use that instead?

As you might notice, we need to have copies both for aarch64 and arch32
(compat system calls).

-Takahiro AKASHI

> Will
>
