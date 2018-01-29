From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Mon, 29 Jan 2018 07:51:41 -0700
Subject: [PATCH 0/4] efi/arm64: unmap the kernel during runtime service
 calls
In-Reply-To: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
References: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
Message-ID: <bdba264b-6619-6e9f-2849-d9d82a820ab0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/25/2018 3:31 AM, Ard Biesheuvel wrote:

> Note that capsule update has been omitted. This is a bit involved, and
> I'd rather get some feedback before burning too many cycles on that. All
> other services should be functional, with the caveat that EFI variable
> names are now limited to 1024 [wide] characters, and UEFI variables
> themselves to 64 KB.
> 

I'm curious, why these limitations?

We don't have any concern about the name length limitation at this time, 
but the variable size one is concerning.

We have a feature which creates a variable greater than 64KB that we 
want to utilize from Linux.  The size limitation would seem to prevent that.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
