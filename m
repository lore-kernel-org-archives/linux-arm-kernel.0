From: christian.perone@gmail.com (Christian S. Perone)
Date: Thu, 21 Aug 2014 17:12:32 -0300
Subject: set_memory_ro/set_memory_rw for ARM
In-Reply-To: <53F650FF.4030301@codeaurora.org>
References: <CAMxMOAs=4qgOgHygg5kygyyVcggQithycm_XM0SkxHTH62cnRw@mail.gmail.com>
 <53F650FF.4030301@codeaurora.org>
Message-ID: <CAMxMOAvzMFLfsy3-dU3RL5z842KzTthWdHsb=aFmy6WKBP5OSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Great thanks Laura, that was exactly what I needed.

On Thu, Aug 21, 2014 at 5:05 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> On 8/21/2014 12:18 PM, Christian S. Perone wrote:
>> Does anyone knows if there is any set_memory_ro()/set_memory_rw()
>> (from x86) equivalent for ARM ? I just want to set pages to be
>> read-only (even when in supervisor mode).
>>
>> Thanks !
>>
>
> Yes, set_memory_ro/set_memory_rw were implemented for ARM
> (75374ad47 ARM: mm: Define set_memory_* functions for ARM) and should
> be in v3.14. Note that these are restricted to module addresses only
> since changing individual pages of generic memory is not possible
> due to the section mappings used in lowmem.
>
> Thanks,
> Laura
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation



-- 
Blog | Github | Twitter
"Forgive, O Lord, my little jokes on Thee, and I'll forgive Thy great
big joke on me."
