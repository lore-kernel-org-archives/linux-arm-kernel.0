From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Feb 2014 15:48:04 +0100
Subject: [PATCH 1/1] ARM: Exynos: Add generic compatible string
In-Reply-To: <53075239.4010603@samsung.com>
References: <1392809645-631-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHyWG1ac6isTRSB3VWfxER9cSuDJHwY3b7svyEk9EozpWQ@mail.gmail.com>
 <53075239.4010603@samsung.com>
Message-ID: <2200834.G3JJLYQl5i@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 February 2014 14:18:49 Tomasz Figa wrote:
> 
> > Now that we have a broader agreement on this, I think we can go ahead with the
> > following steps as an initial approach:
> > 1. Have a common machine file for both exynos4 and 5 files, mach-exynos-dt.c.
> > 2. Introduce a generic compatible string "samsung,exynos".
> > 3. Append this to the compatible property list for existing boards.
> >
> > If this plan looks OK, I can send across patches doing this.
> >
> 
> Looks good. I would also merge common.c with this resulting 
> mach-exynos-dt.c, as it would be the only user of the code there.

Sounds good. While the naming is not important, I would just call the
file 'exynos.c', in line with some of the other platforms we have.
Both the 'mach-' and the '-dt' part of the file name are redundant.

Alternatively, you could merge it all into common.c.

	Arnd
