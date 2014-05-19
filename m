From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Mon, 19 May 2014 16:24:31 +0530
Subject: [PATCH 1/1] arm64: TLB maintainance: Implement flush_kern_tlb_page
In-Reply-To: <20140519104632.GI5113@arm.com>
References: <1400495665-48279-1-git-send-email-ritesh.harjani@gmail.com>
 <1400495665-48279-2-git-send-email-ritesh.harjani@gmail.com>
 <20140519104632.GI5113@arm.com>
Message-ID: <CAD15agbbyEPbM5rw9gfAC5qMUxi-0rWp58J40j2XYYyf27rozQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Mon, May 19, 2014 at 4:16 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, May 19, 2014 at 11:34:25AM +0100, ritesh.harjani at gmail.com wrote:
>> From: Ritesh Harjani <ritesh.harjani@gmail.com>
>>
>> Implement flush_kern_tlb_page mentioned in the header
>> comment of arch/arm64/include/asm/tlbflush.h
>
> Alternatively, clean-up the comment.

You mean this function is of no use ? Or there are other plans which
might require clean up of this file ?

Also, could you please confirm whether the implementation of the
function is correct ?

>> +       asm("tlbi       vae1is, %0" : : "r" (addr));

Should following instruction be more appropriate instead of above:
asm("tlbi       vaae1is, %0" : : "r" (addr));

>
> --
> Catalin


Thanks
Ritesh
