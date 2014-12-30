From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 23:05:57 +0100
Subject: [PATCH 7/9] ARM: versatile: move mach includes into mach directory
In-Reply-To: <1419967718-26909-8-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-8-git-send-email-robherring2@gmail.com>
Message-ID: <4692855.QAqGntT4PC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 December 2014 13:28:36 Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> In preparation for multi-platform support, move platform.h and
> hardware.h into mach-versatile directory. Combine them into a single
> file in the process.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-versatile/core.c                     |  3 +-
>  arch/arm/mach-versatile/include/mach/hardware.h    | 32 ----------------------
>  .../mach-versatile/{include/mach => }/platform.h   |  5 ++++
>  3 files changed, 6 insertions(+), 34 deletions(-)
> 

If I read this right, there is only one file left that includes this
header after patch 9, so how about moving the contents into versatile_dt.c
directly?

	Arnd
