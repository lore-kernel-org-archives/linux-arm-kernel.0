From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 19 May 2018 15:35:55 -0700
Subject: [PATCH v3 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
In-Reply-To: <20180410183210.28052-1-andrew.smirnov@gmail.com>
References: <20180410183210.28052-1-andrew.smirnov@gmail.com>
Message-ID: <CAHQ1cqGCG0rwPcpoY+bnjcyupg18x1TvULJzvAjRxSkL6z1U_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 11:32 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Platform device core assumes the ownership of dev.platform_data as
> well as that it is dynamically allocated and it will try to kfree it
> as a part of platform_device_release(). Change the code to use
> platform_device_add_data() n instead of a pointer to a static memory
> to avoid causing a BUG() when calling platform_device_put().
>
> The problem can be reproduced by artificially enabling the error path
> of platform_device_add() call (around line 357).
>
> Note that this change also allows us to constify imx7_pgc_domains,
> since we no longer need to be able to modify it.
>

Shawn,

What's the status of these two patches? Do I need to change anything
or are they good to go?

Thanks,
Andrey Smirnov
