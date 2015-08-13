From: HenryC.Chen@mediatek.com (Henry Chen)
Date: Thu, 13 Aug 2015 23:25:05 +0800
Subject: [PATCH] regmap: Add function check before called format_val
In-Reply-To: <CAGS+omDa+FhKD2u_VwBG3cWvN+ZiHneqFVz=mtdYuPsiQu4JEQ@mail.gmail.com>
References: <1437396110-5192-1-git-send-email-henryc.chen@mediatek.com>
 <20150720150254.GC11162@sirena.org.uk>
 <1437458845.30329.51.camel@mtksdaap41>
 <CAGS+omDa+FhKD2u_VwBG3cWvN+ZiHneqFVz=mtdYuPsiQu4JEQ@mail.gmail.com>
Message-ID: <1439479505.32674.43.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-12 at 22:20 +0800, Daniel Kurtz wrote:

> 
> Since I didn't see it elsewhere in this discussion, I'll point out
> that the "regression" here was introduced by commit [0], which added
> the call to map->format.format_val from regmap_bulk_read() when
> map->bus == NULL.
> 
> [0] commit 15b8d2c41fe5839582029f65c5f7004db451cc2b
>   Author: Arun Chandran <achandran@mvista.com>
>   regmap: Fix regmap_bulk_read in BE mode
> 
> Perhaps the easiest work around to unbreak v4.2 is, as Henry mentions,
> for mtk_pmic_wrap to define its own regmap_bus, with .read() &
> .write() handlers.  This way they will inherit the default built-in
> format_val() from the regmap core.
> 
> Making mtk_pmic-wrap into a regmap_bus makes a bit of sense
> architecturally, too, since it is essentially just a bus for accessing
> the registers of an off-chip PMIC.  The CPU sees a platform bus, but
> the registers of the remote PMIC are accessed over a dedicated SPI
> bus.
> 
> WDYT?
> 
> Henry, can you try to implement this?

Hi Daniel,
I can try to create a regmap_bus for pmic wrap. But I'm not sure if it
was the good solution for this problem.

Hi Mark,
Sorry, I'm afraid that I cannot do this right on init as you said last
time. What do you think about regmap_bus, can you accept that way?

Thanks,
Henry
> 
> Thanks,
> -Dan
