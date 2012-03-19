From: khilman@ti.com (Kevin Hilman)
Date: Mon, 19 Mar 2012 14:48:31 -0700
Subject: [PATCH] OMAP2+: OPP: allow OPP enumeration to continue if device
 is not present
In-Reply-To: <1331914749-23171-1-git-send-email-nm@ti.com> (Nishanth Menon's
 message of "Fri, 16 Mar 2012 11:19:09 -0500")
References: <1331914749-23171-1-git-send-email-nm@ti.com>
Message-ID: <8739945kk0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> On platforms such as OMAP3, certain variants may not have IVA, SGX
> or some specific component. We currently have a check to aid fixing
> wrong population of OPP entries for issues such as typos. This however
> causes a conflict with valid requirement where the SoC variant does
> not actually have the module present.
>
> So, reduce the severity of the print to a debug statement and skip
> registering that specific OPP, but continue down the list.
>
> Reported-by: Steve Sakoman <steve@sakoman.com>
> Reported-by: Maximilian Schwerin <mvs@tigris.de>
> Acked-by: Steve Sakoman <steve@sakoman.com>
> Tested-by: Maximilian Schwerin <mvs@tigris.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing as a fix for for v3.4-rc (branch: for_3.4/fixes/pm)

Kevin
