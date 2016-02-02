From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Tue, 2 Feb 2016 15:39:57 -0600
Subject: [RFC PATCH 0/3] arm64 initrd mapping/relocation
In-Reply-To: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <56B1222D.3000604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2016 11:56 AM, Ard Biesheuvel wrote:
> After discussing in linux-efi with Mark, and on #armlinux with Will, this is
> a proposal for dealing with initrd memory that is potentially not covered by
> the linear region.
>
> Note that this will look slightly differently when some of the KASLR work gets
> merged, but this should only affect the way we deal with the initrd if it sits
> outside of the linear region.
>
> Mostly intended for discussion, not tested at all.
>
> Ard Biesheuvel (3):
>    memblock: add routine to clear the MEMBLOCK_NOMAP flag for a region
>    arm64: add the initrd region to the linear mapping explicitly
>    arm64: remove the now unneeded relocate_initrd()

I discovered the original problem on AMD Seattle and these patches
fixed it for me.

Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
