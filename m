From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 21 Aug 2014 13:05:19 -0700
Subject: set_memory_ro/set_memory_rw for ARM
In-Reply-To: <CAMxMOAs=4qgOgHygg5kygyyVcggQithycm_XM0SkxHTH62cnRw@mail.gmail.com>
References: <CAMxMOAs=4qgOgHygg5kygyyVcggQithycm_XM0SkxHTH62cnRw@mail.gmail.com>
Message-ID: <53F650FF.4030301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/21/2014 12:18 PM, Christian S. Perone wrote:
> Does anyone knows if there is any set_memory_ro()/set_memory_rw()
> (from x86) equivalent for ARM ? I just want to set pages to be
> read-only (even when in supervisor mode).
> 
> Thanks !
> 

Yes, set_memory_ro/set_memory_rw were implemented for ARM
(75374ad47 ARM: mm: Define set_memory_* functions for ARM) and should
be in v3.14. Note that these are restricted to module addresses only
since changing individual pages of generic memory is not possible
due to the section mappings used in lowmem.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
