From: philip@cog.systems (Philip Derrin)
Date: Tue, 14 Nov 2017 13:48:16 +1100
Subject: [PATCH 0/2] STRICT_KERNEL_RWX weakened on ARM by CONFIG_ARM_LPAE=y
In-Reply-To: <20171109093734.GB12318@n2100.armlinux.org.uk>
References: <20171109004144.2246-1-philip@cog.systems>
 <CAGXu5jKBipDwQLz=ez8-SCW4=QNw8hNi+e4NYzQhbfEFACggcQ@mail.gmail.com>
 <20171109093734.GB12318@n2100.armlinux.org.uk>
Message-ID: <1584344d-46bd-b9f8-ce15-3d80cd725dc0@cog.systems>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/17 20:37, Russell King - ARM Linux wrote:
> On Wed, Nov 08, 2017 at 05:23:43PM -0800, Kees Cook wrote:
>> On Wed, Nov 8, 2017 at 4:41 PM, Philip Derrin <philip@cog.systems> wrote:
>>> Hi,
>>>
>>> This patch series fixes a bug which makes CONFIG_STRICT_KERNEL_RWX ineffective
>>> when CONFIG_ARM_LPAE is enabled. Specifically, the kernel text and rodata are
>>> mapped writeable. This has been the case since DEBUG_RODATA for ARM was first
>>> merged in 3.19.
>>>
>>> The cause was an incorrect conflict resolution in 1e3479225acb ("ARM: 8275/1:
>>> mm: fix PMD_SECT_RDONLY undeclared compile error") between the commit that
>>> implemented DEBUG_RODATA, 80d6b0c2eed2 ("ARM: mm: allow text and rodata
>>> sections to be read-only"), and another that moved the LPAE read-only bit into
>>> a software bit, ded947798469 ("ARM: 8109/1: mm: Modify pte_write and pmd_write
>>> logic for LPAE").
>>>
>>> The incorrect mappings were not apparent in the debugfs kernel_page_tables
>>> dump because that was checking only the software RO bit, not the hardware RO
>>> bit.
>> Thanks for catching this! Please consider both patches:
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
> Where are these patches, and why weren't they copied to the arm kernel
> list?

I've added these to the patch tracker, as 8721/1 and 8722/1.

Thanks,
Philip
