From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Fri, 13 Apr 2018 09:19:07 -0600
Subject: [PATCH] soc: ti: knav_qmss: Use percpu instead atomic for stats
 counter
In-Reply-To: <63d79bc4-2ee1-2350-2431-ae41b53b0914@oracle.com>
References: <20180411191629.21545-1-gomonovych@gmail.com>
 <63d79bc4-2ee1-2350-2431-ae41b53b0914@oracle.com>
Message-ID: <89591f43-19c6-26b5-c0f7-e370721ec397@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/18 3:28 PM, santosh.shilimkar at oracle.com wrote:
> On 4/11/18 12:16 PM, Vasyl Gomonovych wrote:
>> Hwqueue has collect statistics in heavy use queue_pop/queu_push functions
>> for cache efficiency and make push/pop faster use percpu variables.
>> For performance reasons, driver should keep descriptor in software 
>> handler
>> as short as possible and quickly return it back to hardware queue.
>> Descriptors coming into driver from hardware after pop and return back
>> by push to reduce descriptor lifetime in driver collect statistics on 
>> percpu.
>>
>> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
>> ---
> This is really good idea. Have you tested this patch ? If not it needs
> to be tested on Keystone SOCs to make sure all works.
> 
Thanks for confirming the tests done with rapidIO offlist. Will queue
this patch for next merge window.

Regards,
Santosh
