From: schwab@suse.de (Andreas Schwab)
Date: Tue, 21 Jun 2016 13:34:59 +0200
Subject: [PATCH 08/19] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
In-Reply-To: <576915B0.5040706@huawei.com> (Zhangjian's message of "Tue, 21
 Jun 2016 18:23:44 +0800")
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-9-git-send-email-ynorov@caviumnetworks.com>
 <576915B0.5040706@huawei.com>
Message-ID: <mvmk2hipyfw.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> writes:

>> @@ -78,9 +79,9 @@
>>
>>   #ifdef CONFIG_COMPAT
>>   #define TASK_SIZE_32		UL(0x100000000)
>> -#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
>> +#define TASK_SIZE		(is_compat_task() ?		\
>>   				TASK_SIZE_32 : TASK_SIZE_64)
>> -#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
>> +#define TASK_SIZE_OF(tsk)	(is_compat_thread(tsk) ? \
> It should be
> +#define TASK_SIZE_OF(tsk)      (is_compat_thread(task_thread_info(tsk)) ? \
> is_compat_thread takes "struct thread_info *thread" while TASK_SIZE_OF takes
> "struct task_struct *tsk"tsk.

If that doesn't throw an error does that mean that TASK_SIZE_OF is
unused?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
