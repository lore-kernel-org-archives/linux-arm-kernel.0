From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 12 Apr 2017 15:58:07 -0500
Subject: [PATCH 5/8] arm64: defconfig: enable EFI_VARS and
 EFI_CAPSULE_LOADER
In-Reply-To: <20170412161442.GB7153@leverpostej>
References: <1492012980-11650-1-git-send-email-timur@codeaurora.org>
 <1492012980-11650-6-git-send-email-timur@codeaurora.org>
 <a80a1b2f-e5fa-36c7-5175-8a9718584720@arm.com>
 <20170412161442.GB7153@leverpostej>
Message-ID: <b795d943-c85f-4f39-ec13-2388f6f7f6bb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2017 11:14 AM, Mark Rutland wrote:
>>> > > Many ARM64 server systems boot via EFI, so enable support for some EFI
>>> > > options to allow applications to interact with EFI.
>>> > > 
>>> > > CONFIG_EFI_VARS enables sysfs support for reading and writing variables
>> > 
>> > Isn't efivarfs preferred for that these days, or have I imagined that?
>> > 
>> > Robin.
> Ard, Leif?

So my research suggests that efivarfs is a replacement for CONFIG_EFI_VARS.
We may still have some older programs that use the sysfs entries, but I'm
not sure.

Regardless, I will drop EFI_VARS from v2 of the patset, and just set
EFI_CAPSULE_LOADER.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
