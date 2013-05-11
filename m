From: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 11 May 2013 08:47:28 -0700
Subject: [PATCH -v10 09/11] arm,
 prepare reboot_mode for moving to	generic kernel code.
In-Reply-To: <20130511130457.GD18614@n2100.arm.linux.org.uk>
References: <1368273447-11958-1-git-send-email-holt@sgi.com>
 <1368273447-11958-10-git-send-email-holt@sgi.com>
 <20130511130457.GD18614@n2100.arm.linux.org.uk>
Message-ID: <588ed084-fed7-4bd9-bcd7-a32f40bd404a@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By the way, do we really need Yoda programming here?

Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

>On Sat, May 11, 2013 at 06:57:25AM -0500, Robin Holt wrote:
>> This patch prepares for the moving the parsing of reboot= to the
>generic
>> kernel code by making reboot_mode into a more generic form.
>> 
>> Signed-off-by: Robin Holt <holt@sgi.com>
>> To: Andrew Morton <akpm@linux-foundation.org>
>> To: Russell King <linux@arm.linux.org.uk>
>> Cc: Russ Anderson <rja@sgi.com>
>> Cc: Robin Holt <holt@sgi.com>
>> Cc: H. Peter Anvin <hpa@zytor.com>
>> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
>> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>> Cc: the arch/x86 maintainers <x86@kernel.org>
>> Cc: Arm Mailing List <linux-arm-kernel@lists.infradead.org>
>
>Almost-but-not-quite-Acked-by: Russell King
><rmk+kernel@arm.linux.org.uk> :)
>
>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>> index f219703..92b47df 100644
>> --- a/arch/arm/kernel/process.c
>> +++ b/arch/arm/kernel/process.c
>> @@ -174,14 +174,14 @@ void arch_cpu_idle(void)
>>  		default_idle();
>>  }
>>  
>> -static char reboot_mode = 'h';
>> +enum reboot_mode reboot_mode = REBOOT_HARD;
>>  
>> -int __init reboot_setup(char *str)
>> +static int __init reboot_setup(char *str)
>>  {
>> -	reboot_mode = str[0];
>> +	if ('s' == str[0])
>> +		reboot_mode = REBOOT_SOFT;
>
>Remember we talked about the 'gpio' mode as well, so you also need here
>+	if ('g' == str[0])
>		reboot_mode = REBOOT_GPIO;

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
