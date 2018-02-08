From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Thu, 8 Feb 2018 16:41:23 +0800
Subject: [PATCH v5 2/3] GHES: add a notify chain for process memory section
In-Reply-To: <20180207103145.GC8944@pd.tnic>
References: <1516969885-150532-1-git-send-email-xiexiuqi@huawei.com>
 <1516969885-150532-3-git-send-email-xiexiuqi@huawei.com>
 <20180207103145.GC8944@pd.tnic>
Message-ID: <a26d3082-ef72-9684-5f22-4d65b8adb998@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thanks for your comments.

On 2018/2/7 18:31, Borislav Petkov wrote:
> On Fri, Jan 26, 2018 at 08:31:24PM +0800, Xie XiuQi wrote:
>> Add a notify chain for process memory section, with
>> which other modules might do error recovery.
>>
>> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
>> Tested-by: Wang Xiongfeng <wangxiongfeng2@huawei.com>
>> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>  drivers/acpi/apei/ghes.c | 10 ++++++++++
>>  include/acpi/ghes.h      |  8 ++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index cff671d..1f0ebfb 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -109,6 +109,9 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>>  static LIST_HEAD(ghes_hed);
>>  static DEFINE_MUTEX(ghes_list_mutex);
>>  
>> +ATOMIC_NOTIFIER_HEAD(ghes_mem_err_chain);
>> +EXPORT_SYMBOL(ghes_mem_err_chain);
> 
> Definitely not EXPORT_SYMBOL.
> 
> And certainly not export the notifier head. Have register and unregister
> functions instead.
> 
> That is, *if* you can't solve it differently with James. Notifiers
> should be avoided if possible.
> 

Yes, I saw the patchset, I agree. I will work with James to solve the problem.

-- 
Thanks,
Xie XiuQi
