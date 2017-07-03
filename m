From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Jul 2017 14:35:31 +0200
Subject: [PATCH] ARM: owl: smp: Drop bogus holding pen
In-Reply-To: <20170701212930.606-1-afaerber@suse.de>
References: <CAK8P3a1vCKkZ8i=MLQXHX5ZowWQGbqiMo3gQz1E9RV+8sSGfpA@mail.gmail.com>
 <20170701212930.606-1-afaerber@suse.de>
Message-ID: <CAK8P3a3R9g2S4cPDhgYK2rPmLxjvs0ki1kg5vY_1zPZwcbttQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 1, 2017 at 11:29 PM, Andreas F?rber <afaerber@suse.de> wrote:
> The S500 SoC can start secondary CPUs without busy-looping for pen_release,
> so simplify the SMP code compared to the LeMaker kernel tree.
>
> Fixes: 172067e0bc87 ("ARM: owl: Implement CPU enable-method for S500")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: David Liu <liuwei@actions-semi.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Looks good to me. I applied both on top of next/soc before tagging the
branch for 4.13,
so this version is going to be what we merge.

I saw that David had another suggestion for simplifying it further.
That also looks
good, but it's less urgent, so please implement that as an add-on patch and send
it for 4.14, unless you decide there is a reason it needs to be
included in 4.13 as
well.

Thanks!

        Arnd
