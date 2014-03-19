From: grundler@chromium.org (Grant Grundler)
Date: Wed, 19 Mar 2014 11:37:57 -0700
Subject: [PATCH v11 17/27] iommu/exynos: remove calls to Runtime PM API
 functions
In-Reply-To: <5329D426.9020706@samsung.com>
References: <20140314140843.ba055f28dd7ed59c46088029@samsung.com>
 <5322FD14.5090602@samsung.com>
 <20140318185605.0380c8dfe6559c06183092e5@samsung.com>
 <532861BE.7020601@samsung.com>
 <20140319100304.5e26fa43ccdfc29178b058e1@samsung.com>
 <532997D7.6090608@samsung.com>
 <CANEJEGuYz28dGT+264CYtG+Tk6htOq=u-t4PWMtsij32X0vJFA@mail.gmail.com>
 <5329D426.9020706@samsung.com>
Message-ID: <CANEJEGtCdMmWXwpoky8USLOBw7jAt1bRw8or-mDK7twxAzhWpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 10:30 AM, Tomasz Figa <t.figa@samsung.com> wrote:
...
> As I said, AFAIK the trend is to get rid of ordering by initcalls and make
> sure that drivers can handle missing dependencies properly, even for
> "services" such as DMA, GPIO, clocks and so on, which after all are provided
> by normal drivers like other.

Ok - I'm not following the general kernel dev trends. initcall()
levels are easy to understand and implement. So I would not be in a
hurry to replace them.

>> ps. I've written IOMMU support for four different IOMMUs on three
>> operating systems (See drivers/parisc for two linux examples). But I
>> still feel like I at best have 80% understanding of how this one is
>> organized/works. Abstract descriptions and convoluted code have been
>> handicapping me (and lack of time to dig further).
>
>
> Well, this is one of my concerns with this driver. It isn't easy to read
> (and so review, maintain, extend and debug found issues).

My postscript comment was more to explain why I'm not confident in my
opinion - not a reason to reject the patch series.  I still consider
the whole series as a step forward. But I'm not the expert here.

Right now, with ~30 patches posted by the exynos iommu (official?)
maintainer, no one else who has a clue will attempt to fix or clean up
those kinds of problems.  i.e. it's useful to enable others to fix
what are essentially unspecified "design pattern" issues.

cheers,
grant
