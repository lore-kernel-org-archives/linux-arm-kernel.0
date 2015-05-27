From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 28 May 2015 00:19:44 +0900
Subject: [RFC PATCH 1/2] kernel/fork.c: add a function to calculate page
 address from thread_info
In-Reply-To: <CAHGf_=oMDPscgJ0bdr+QrV24n3KL3BC5qe8KGa=dePxg4tc4Zg@mail.gmail.com>
References: <1432483292-23109-1-git-send-email-jungseoklee85@gmail.com>
 <CAHGf_=oMDPscgJ0bdr+QrV24n3KL3BC5qe8KGa=dePxg4tc4Zg@mail.gmail.com>
Message-ID: <A747CC27-C3AB-4322-827D-FBC10A69A5D2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 27, 2015, at 12:49 PM, KOSAKI Motohiro wrote:

Hello, KOSAKI,

> On Sun, May 24, 2015 at 12:01 PM, Jungseok Lee <jungseoklee85@gmail.com> wrote:
>> A current implementation assumes thread_info address is always correctly
>> calculated via virt_to_page. It restricts a different approach, such as
>> thread_info allocation from vmalloc space.
>> 
>> This patch, thus, introduces an independent function to calculate page
>> address from thread_info one.
>> 
>> Suggested-by: Sungjinn Chung <barami97@gmail.com>
>> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
>> Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>> kernel/fork.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> I haven't receive a path [2/2] and haven't review whole patches. But
> this patch itself is OK to me.
> Acked-by: KOSAKI Motohiro <kosaki.motohiro@fujitsu.com>

Thanks!

I didn't add you to Cc list since [PATCH 2/2] is architecture specific.
According to the feedbacks, it is needed to figure out fundamental solutions:
1) reduce stack size and 2) focus on a generic anti-fragmentation logic.

Please refer to https://lkml.org/lkml/2015/5/24/121 for [PATCH 2/2].

Best Regards
Jungseok Lee
