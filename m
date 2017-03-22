From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Mar 2017 15:49:21 -0400
Subject: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
In-Reply-To: <CAKv+Gu8Uw-X3AR6aQYevPdRfcgPNnqL4O3sRoKxsZAiW29sbqg@mail.gmail.com>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
 <31da6db5-be22-9e84-5e76-67c519bc0b34@codeaurora.org>
 <CAKv+Gu8Uw-X3AR6aQYevPdRfcgPNnqL4O3sRoKxsZAiW29sbqg@mail.gmail.com>
Message-ID: <704b8b8c-e607-29b3-e101-bbecd90073bb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/22/2017 3:41 PM, Ard Biesheuvel wrote:
>> As far as I know, kernel honors resource assignments done by the UEFI BIOS if
>> they are correct. Kernel will reassign the resources only if something is wrong.
>>
> No, the kernel always reassigns all BARs on arm64.

I think this is where the problem is.

I'm not seeing this happen on QDF2400 which supports ACPI + UEFI BIOS
combination only. 

I see that kernel honored the resources assigned by UEFI BIOS if I compare
the BAR addresses.

I see reassignment only when something is horribly broken. Then, there would
be a bridge configuration invalid message in the boot log to confirm this.

> 
>> Will this code break other platforms/architectures?
>>
> Which platforms/architectures are you referring to? EFIFB on a PCI
> device is currently broken on arm64. 

In general or on your particular platform?

> On x86, it works, given that BARs
> are usually not reassigned, and so the patch should be a no-op in that
> case (although I'd argue it is still an improvement to check whether
> the device that owns the BAR actually has memory decoding enabled
> before we attach the framebuffer driver to it)
> 

I'm fine as long as it doesn't break anything. That's why, I'm asking.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
