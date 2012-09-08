From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Sep 2012 10:24:33 +0200
Subject: [PATCH 2/3] ARM: EXYNOS: pm_domain: Fix power domain name
 initialization
In-Reply-To: <CAJuYYwQWEN3FiNwQdugeKRV53cA65WdW79trcmP2kqqOPbz+sg@mail.gmail.com>
References: <1346924286-9584-1-git-send-email-t.figa@samsung.com>
 <1346924286-9584-3-git-send-email-t.figa@samsung.com>
 <CAJuYYwQWEN3FiNwQdugeKRV53cA65WdW79trcmP2kqqOPbz+sg@mail.gmail.com>
Message-ID: <3430339.QiHB9nIcXj@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Saturday 08 of September 2012 13:37:59 Thomas Abraham wrote:
> > -               pd->name = np->name;
> > +               pd->pd.name = kstrdup(np->name, GFP_KERNEL);
> > +               pd->name = pd->pd.name;
> 
> Since device tree blob is always resident, why not just use np->name
> instead of copying it to a new place?

The problem is that np->name is const, while pd->pd.name is not.

--
Best regards,
Tomasz Figa
