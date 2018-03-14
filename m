From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Mar 2018 12:40:10 -0700
Subject: [PATCH 0/4] ARM: brcmstb: Add support for the V7 memory map
In-Reply-To: <20180223210923.544-1-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
Message-ID: <d1c70d19-2d37-1fcd-5945-721557ab6962@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2018 01:09 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series updates the brcmstb.S DEBUG_LL routines to dynamically detect
> one of the latest STB chip: BCM7278. This chip has a different memory map which
> requires use to lookup the main ID register to know whether which register
> physical offset we must use.
> 
> As a consequence of doing that, we do a number of things:
> 
> - allow the inclusion of cputype.h in assembly files to reduce the duplication
>   of constants
> - define the Brahma-B53 and Brahma-B15 main ID register values, which was long
>   overdue
> - finaly update brcmstb.S to detect 7278 and offset the base register address
>   accordingly
> 
> Note that Doug had a slightly different approach in our downstream tree where he
> actually added the same MIDR_* constants similar to what ARM64 has, I took that
> part away in order to minimize the delta, but I can easily submit that patch
> if this is the desired direction moving forward.

Russell, I would be more comfortable taking those changes through our
Broadcom ARM SoC pull requests, since the majority of the changes are in
brcmstb.S, can I get your acknowledgment for the first 3 patches?

Thank you!

> 
> Thank you!
> 
> Doug Berger (3):
>   ARM: Allow this header to be included by assembly files
>   ARM: add Broadcom Brahma-B53 main ID definition
>   ARM: brcmstb: Add support for the V7 memory map
> 
> Florian Fainelli (1):
>   ARM: add Broadcom Brahma-B15 main ID definition
> 
>  arch/arm/include/asm/cputype.h   | 15 ++++++++++++---
>  arch/arm/include/debug/brcmstb.S | 21 ++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 


-- 
Florian
