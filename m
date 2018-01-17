From: gkohli@codeaurora.org (Kohli, Gaurav)
Date: Wed, 17 Jan 2018 11:34:25 +0530
Subject: Query : Regarding overwriting of DTB loading region while
 clearing BSS section
In-Reply-To: <20171123182132.mhk5dxnj4n47igo5@lakrids.cambridge.arm.com>
References: <a61a6216-cd8d-f172-df41-404a4888eb38@codeaurora.org>
 <20171123141048.hocde5isp6wj7qes@lakrids.cambridge.arm.com>
 <7c215883-8ae2-67ef-4c6b-a043ef2740bc@codeaurora.org>
 <20171123182132.mhk5dxnj4n47igo5@lakrids.cambridge.arm.com>
Message-ID: <e148ad3a-9682-338a-816f-cc4bdfd0f772@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Chandra , He has some made some patch related to this.

On 11/23/2017 11:51 PM, Mark Rutland wrote:

> On Thu, Nov 23, 2017 at 10:26:07PM +0530, Kohli, Gaurav wrote:
>> Hi Mark,
>>
>> Thanks for the reply,
>>
>> Actually, We solved our issue by removing unwanted code from kernel,
> I would very strongly recommend that you update your bootladoer/firmware
> to respect image_size, since any numbero f things may increase the size
> of the kernel in future.
>
> i.e. trimmign the kernel down is a workaround, but not a fix.
>
>> But my request can't we put some check itself in head.s during clear
>> of BSS region to check whether dtb is intact or not.  Because
>> ultimately it will fail in start kernel.
>> At that point(start_kernel),? we can not directly say what is the root cause
>> for this overriding.
> Perhaps we could add a check in setup_arch(). If the DTB pointer
> overlaps any part of the kerenl (BSS included), the bootloader is
> clearly broken.
>
> Even then, it's going to be a slient panic(), since we won't be able to
> parse anything out of the DTB...
>
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
