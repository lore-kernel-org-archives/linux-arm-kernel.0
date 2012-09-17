From: cjb@laptop.org (Chris Ball)
Date: Mon, 17 Sep 2012 10:01:00 -0400
Subject: [PATCH] mmc: mxs-mmc: implement broken-cd
In-Reply-To: <50572907.6000700@bluegiga.com> (Lauri Hintsala's message of
 "Mon, 17 Sep 2012 16:43:35 +0300")
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20120910060840.GT26709@S2101-09.ap.freescale.net>
 <504DBB10.9030702@bluegiga.com>
 <CAKGA1bm990BXJuZ=sQFgaciJxeP_ytPV2tfm1rHi=s=w7b-OYg@mail.gmail.com>
 <505096EF.8060208@bluegiga.com> <50572907.6000700@bluegiga.com>
Message-ID: <m3boh4n3z7.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 17 2012, Lauri Hintsala wrote:
> Is it OK to use broken-cd? broken-cd feature is documented as "There
> is no card detection available; polling must be used". In this case
> the card detect is not broken but it is unrouted so it is unavailable.
>
> Documentation about broken-cd has been added by commit:
> https://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commitdiff;h=abe1e05da365350ac282ba5f6831aae13d97074e

I'm having trouble following the problem; it sounds like perhaps all you
need is:

        if (of_find_property(np, "non-removable", NULL))
                mmc->caps |= MMC_CAP_NONREMOVABLE;

Have you tried that?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
