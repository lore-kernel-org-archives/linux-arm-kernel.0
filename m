From: labbott@redhat.com (Laura Abbott)
Date: Tue, 12 Dec 2017 15:30:00 -0800
Subject: How to debug "insecure W+X mapping"?
In-Reply-To: <bff5a2b3-0d93-5f55-c129-4b14a5a09b45@codeaurora.org>
References: <bff5a2b3-0d93-5f55-c129-4b14a5a09b45@codeaurora.org>
Message-ID: <680ec27a-1557-f2d9-8159-bd49326bd36c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2017 02:57 PM, Timur Tabi wrote:
> We have a 4.10-based kernel that occasionally displays an insecure W+X mapping (courtesy of CONFIG_DEBUG_WX):
> 
> [??? 7.151680] arm64/mm: Found insecure W+X mapping at address 0000345a049d2000/0x345a049d2000
> ...
> [??? 7.435481] Checked W+X mappings: FAILED, 4 W+X pages found, 0 non-UXN pages found
> 
> The number of actual W+X pages varies, e.g. sometimes it says 6 pages.
> 
> How do I go about debugging this? How do I identify the source of 0000345a049d2000?	
> 

That's a funny address. The check was written to scan the init_mm
page table but that's not a kernel address on arm64. It almost looks
like something set up a userspace mapping very early in the boot process?

I'd start by dumping the physical address at that address to
see if that gives a suggestion where the mapping came from.

Thanks,
Laura
