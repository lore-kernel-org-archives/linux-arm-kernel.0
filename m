From: geoff@infradead.org (Geoff Levand)
Date: Mon, 5 Dec 2016 09:41:06 -0800
Subject: [PATCH] arm64: Add CMDLINE_EXTEND
In-Reply-To: <20161205120842.GA14429@e104818-lin.cambridge.arm.com>
References: <61060b44-64a9-d628-4faf-3a7ae06048aa@infradead.org>
 <20161205120842.GA14429@e104818-lin.cambridge.arm.com>
Message-ID: <b958f2b6-73fd-e4f5-4fa5-6d2f8330da8f@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 12/05/2016 04:08 AM, Catalin Marinas wrote:
> On Fri, Dec 02, 2016 at 02:17:02PM -0800, Geoff Levand wrote:
>> The device tree code already supports CMDLINE_EXTEND,
>> so add the config option to make it available on arm64.
> 
> What's your use-case for this patch? Note that both CMDLINE_FORCE and
> CMDLINE_EXTEND (if we introduce it) are ignored by the EFI stub.
> However, we don't seem to have stated this anywhere.

I use this in CoreOS, where we need to set "acpi=force" for
arm64.  CoreOS uses a proper UEFI + grub.

See: 

  https://github.com/coreos/scripts/pull/610
  https://github.com/coreos/coreos-overlay/pull/2298

I can add a comment for EFI stub, either in the Kconfig
options, and/or in Documentation/efi-stub.txt.  Just let
me know.

-Geoff
 
