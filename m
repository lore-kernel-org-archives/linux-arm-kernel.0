From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sun, 19 Nov 2017 22:28:03 +0100
Subject: [PATCH 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171116232239.16823-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
Message-ID: <0041277a-f580-1c35-7a6b-5154e676e82f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lukasz!

On 17/11/17 00:22, Lukasz Majewski wrote:
> This patch series adds support for Liebherr's BK3 board, being
> a derivative of TS72XX design.
> 
> This patchset consists of following patches:
> 
> - ts72xx.[c|h] cosmetic cleanup/improvement
> - Move the common code for ts72xx and BK3 to ts72xx-common.c - this
>   code can be reused by other designs build around ts72xx
> - The Liebherr's BK3 board has been added with re-using code of
>   ts72xx.c
> 
> Lukasz Majewski (4):
>   ARM: ep93xx: ts72xx: Use DEFINE_RES_MEM macros where applicable

The patch 3/4 deletes everything added by patch 1/4, so I don't really see the point of it.

>   ARM: ep93xx: ts72xx: Provide include guards for ts72xx.h file
>   ARM: ep93xx: ts72xx: Exclude reusable part of the ts72xx board
>   ARM: ep93xx: ts72xx: Add support for BK3 board - ts72xx derivative

I tend to agree with Hartley, if you'd just add all BK3-related extras to ts72xx.c it would
be less than 60 LoCs, you probably even do not need new Kconfig options.

Alex.
