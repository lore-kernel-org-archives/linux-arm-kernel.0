From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 12:20:40 +0000
Subject: [PATCH] arm64: Add CMDLINE_EXTEND
In-Reply-To: <b958f2b6-73fd-e4f5-4fa5-6d2f8330da8f@infradead.org>
References: <61060b44-64a9-d628-4faf-3a7ae06048aa@infradead.org>
 <20161205120842.GA14429@e104818-lin.cambridge.arm.com>
 <b958f2b6-73fd-e4f5-4fa5-6d2f8330da8f@infradead.org>
Message-ID: <20161206122040.GH2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 09:41:06AM -0800, Geoff Levand wrote:
> On 12/05/2016 04:08 AM, Catalin Marinas wrote:
> > On Fri, Dec 02, 2016 at 02:17:02PM -0800, Geoff Levand wrote:
> >> The device tree code already supports CMDLINE_EXTEND,
> >> so add the config option to make it available on arm64.
> > 
> > What's your use-case for this patch? Note that both CMDLINE_FORCE and
> > CMDLINE_EXTEND (if we introduce it) are ignored by the EFI stub.
> > However, we don't seem to have stated this anywhere.
> 
> I use this in CoreOS, where we need to set "acpi=force" for
> arm64.  CoreOS uses a proper UEFI + grub.

So why can't you just set that in grub if you want to boot with ACPI?

Will
