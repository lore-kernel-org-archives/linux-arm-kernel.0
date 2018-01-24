From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Wed, 24 Jan 2018 18:53:48 +0000
Subject: [PATCH 1/5] drm: rename {drm_clflush_sg, drm_clflush_pages}
In-Reply-To: <CAAfnVB=6BiAn4VMVa0bi1DNajLL2NsiFscQBLrqVdeS65idTbA@mail.gmail.com>
References: <20180124025534.2964-1-gurchetansingh@chromium.org>
 <151678526849.13096.14873692697066951124@mail.alporthouse.com>
 <CAAfnVB=6BiAn4VMVa0bi1DNajLL2NsiFscQBLrqVdeS65idTbA@mail.gmail.com>
Message-ID: <151682002828.13096.9067466884791740951@mail.alporthouse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gurchetan Singh (2018-01-24 18:45:07)
> On Wed, Jan 24, 2018 at 1:14 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> 
>     Quoting Gurchetan Singh (2018-01-24 02:55:30)
>     > Since clfush is an x86-only instruction, these function names won't
>     > make much sense if we start adding cases for other architectures.
> 
>     Whatever your dislike for the name, it has one clear advantage over the
>     new one: it tells you what it is flushing.
>     -Chris
> 
> 
> What do you suggest, if one wants to flush vgem pages on ARM architecture??
> Should we have a drm_clflush_pages(..) and a drm_arm_flush_pages(..), separated
> by #ifdef statements?

drm_cachelines_flush_pages, drm_clflush_pages for short.
Or drm_dcache_flush_pages.
-Chris
