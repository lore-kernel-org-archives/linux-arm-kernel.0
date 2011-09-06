From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Sep 2011 09:19:03 +0200
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdZvb_y6m-uiFu-wMt5XR-UcZGRWUDGrgMFJ9ySzj6VAOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2011 at 7:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The patch removes __init annotation from a few initialization
> functions to make the reinitialization possible. ?For example,
> platform resume function can call l2x0_of_init() to get L2 cache
> back to work.

This will collide with patch 7080/1:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7080/1

Before you put it into the patch tracker can you please rebase it
on that patch and also remove the __init tag from the
l2x0_unlock() function?

Thanks,
Linus Walleij
