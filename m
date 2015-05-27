From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 27 May 2015 11:38:33 +0200
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <55653538.8020206@codeaurora.org>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org>
 <55653538.8020206@codeaurora.org>
Message-ID: <CAKv+Gu8U1SWPb-GJ-3u9t_EX3g18AvOWisK3FycvRWsEdyjpzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 May 2015 at 05:08, Timur Tabi <timur@codeaurora.org> wrote:
> On 05/21/2015 03:15 PM, Geoff Levand wrote:
>>
>> I feel kexec was ready to merge nine months ago.  Users have only sent
>> private e-mails like yourself, so there has been no public inquiries,
>> and so, the arm64 maintainers think kexec is not of interest to users.
>
>
> Does kexec on ARM64 support ACPI?  In some of our initial tests, it appears
> that the kexec'd kernel won't boot because it's expecting a device tree, and
> we don't have one.
>
> ARM64 servers are supposed to use ACPI instead of a device tree.
>

The latest arm64 kexec patches support booting via UEFI, and when
booting via UEFI, the ACPI root pointer is retrieved from a UEFI
configuration table if the FDT contains no system description. So ACPI
support should not depend at all on how kexec is implemented (unless
your FDT does contain a system description, in which case you should
pass along the 'acpi=xxx' param that was given to the cold booted
kernel)

-- 
Ard.
