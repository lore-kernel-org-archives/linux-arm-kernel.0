From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 Jan 2012 14:33:01 -0800
Subject: [PATCH] ARM: Remove BUILD_BUG_ON from asm/bug.h
In-Reply-To: <1325616276-10304-1-git-send-email-sjg@chromium.org>
References: <1325616276-10304-1-git-send-email-sjg@chromium.org>
Message-ID: <4F03821D.9080503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/12 10:44, Simon Glass wrote:
> BUILD_BUG_ON is defined in linux/kernel.h but that is not included by the
> asm/bug.h header which uses it. This causes a build error:
>
> ...include/linux/mtd/map.h: In function 'inline_map_read':
> ...include/linux/mtd/map.h:408:3: error: implicit declaration of function
> 'BUILD_BUG_ON' [-Werror=implicit-function-declaration]
>
> The check is not essential and is not present for other architectures, so
> just remove it.

I thought this check was put in place to catch changes to struct
bug_entry being out of sync with the __BUG macro defined in ARM. Why
can't we include kernel.h instead? Or can you elaborate some more on why
we don't need this check in the commit text?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
