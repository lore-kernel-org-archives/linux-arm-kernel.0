From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 15 Apr 2016 16:06:08 +0200
Subject: [PATCH v16 1/6] efi: ARM/arm64: ignore DT memory nodes instead of
 removing them
In-Reply-To: <20160415140357.GK22906@arm.com>
References: <1460155828-8690-1-git-send-email-ddaney.cavm@gmail.com>
 <1460155828-8690-2-git-send-email-ddaney.cavm@gmail.com>
 <20160415140357.GK22906@arm.com>
Message-ID: <CAKv+Gu_7m0FH5CHLOEPu8uwUKOVMLANGYMd8pvqvp7r+q2Mk4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2016 at 16:03, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Apr 08, 2016 at 03:50:23PM -0700, David Daney wrote:
>> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> There are two problems with the UEFI stub DT memory node removal
>> routine:
>> - it deletes nodes as it traverses the tree, which happens to work
>>   but is not supported, as deletion invalidates the node iterator;
>> - deleting memory nodes entirely may discard annotations in the form
>>   of additional properties on the nodes.
>>
>> Since the discovery of DT memory nodes occurs strictly before the
>> UEFI init sequence, we can simply clear the memblock memory table
>> before parsing the UEFI memory map. This way, it is no longer
>> necessary to remove the nodes, so we can remove that logic from the
>> stub as well.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>  drivers/firmware/efi/arm-init.c    |  8 ++++++++
>>  drivers/firmware/efi/libstub/fdt.c | 24 +-----------------------
>>  2 files changed, 9 insertions(+), 23 deletions(-)
>
> Matt, are you ok with me taking this through the arm64 tree? (since the
> NUMA patches depend on it). If so, please can I have your ack?
>

Matt gave his Reviewed-by for v15

http://www.gossamer-threads.com/lists/linux/kernel/2390242
