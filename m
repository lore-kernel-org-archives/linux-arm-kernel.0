From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Thu, 05 Nov 2015 22:22:05 +0800
Subject: [PATCH] ARM: ACPI: Fix the helper which checks if only a /chosen
 node
In-Reply-To: <CAKv+Gu-EJxogB29vXM-G_KYjHYzXFEzgWX3f=E=3=QVGcRXJaA@mail.gmail.com>
References: <1446728187-14552-1-git-send-email-zhaoshenglong@huawei.com>
 <CAKv+Gu-EJxogB29vXM-G_KYjHYzXFEzgWX3f=E=3=QVGcRXJaA@mail.gmail.com>
Message-ID: <563B660D.4010207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/5 21:59, Ard Biesheuvel wrote:
> On 5 November 2015 at 13:56, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> Assuming that there are several other nodes and a /chosen node in a DTS
>> and the /chosen node is last node, of_scan_flat_dt() will return 0
>
> If those 'several other nodes' are not all subnodes of /chosen, at
> least one of them will be at depth 1, right? Could you give an example
> DTS where this goes wrong?
>
>> while
>> we expect it returns 1 when it's used to call a function to check if
>> there is only a /chosen node in DTS.
>>
>
> of_scan_flat_dt() will terminate early and return 1 on the first
> occasion that the callback returns 1. The callback returns 1 if it
> encounters a node at depth 1 whose name is not 'chosen'. So I am
> failing to see how this code is broken.
>
Oh, I didn't see the !rc within the for() loop before. Sorry for the noise.

-- 
Shannon
