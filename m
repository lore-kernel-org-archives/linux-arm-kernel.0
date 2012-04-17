From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2012 14:47:06 +0000
Subject: [PATCH 15/16] ARM: ux500: Apply Device Tree settings for the
 DB8500 PRCMU
In-Reply-To: <1334659448-11521-16-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-16-git-send-email-lee.jones@linaro.org>
Message-ID: <201204171447.06520.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Lee Jones wrote:
> In this patch we enable the db8500-prcmu via DT and take out
> any enablement previously carried out by platform code.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This patch by itself is broken, because it relies on patch 16.
I suggest merging the two into a single patch to atomically
move over from the static definition of the prcmu to the
device tree based definition. You can also combine it with
patch 14, which by itself is harmless but also pointless.

	Arnd
