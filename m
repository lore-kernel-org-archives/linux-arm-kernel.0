From: s-anna@ti.com (Suman Anna)
Date: Mon, 6 May 2013 19:02:44 -0500
Subject: [PATCHv2 0/4] mailbox: Common API
In-Reply-To: <1367824946-6160-1-git-send-email-jaswinder.singh@linaro.org>
References: <1367824946-6160-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <518844A4.8040203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On 05/06/2013 02:22 AM, Jassi Brar wrote:
> Hello,
>   I have made the implementation look more proper. Also made some changes
> suggested by Suman. Changes since V1:
> 
> * Delete timer upon mailbox release
> * Filled in the stub ipc_links_unregister()
> * Check kzalloc return for errors.
> * Add the controller driver for OMAP2 class. I have taken the patch
>   for mailbox's hwmod from Suman's. The clients are yet to be converted
>   but this should be enough to convey the idea that the API could
>   work for OMAP as well. If I had access to STE documentation, I might
>   have done some implementation for U8500 as well.

The bug fixes in this series look good in general. I have provided my
design comments in the previous RFC thread [1] still, since the overall
changes here are not that much different from the RFC.

Thanks for prototyping the OMAP portions, it demonstrates the adaptation
to the new API, but I have to take a step approach in moving the current
OMAP mailbox code and making incremental changes on top of it. The
mailbox driver is the bottom-most layer in our IPC stacks, so changes at
this layer are very critical to the functional behavior.

regards
Suman

[1] http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg429678.html
