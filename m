From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 7 Jan 2015 12:56:39 +0000
Subject: [PATCH v4 6/8] arm64/efi: move SetVirtualAddressMap() to UEFI stub
In-Reply-To: <CAKv+Gu-aRkoRj5zVXrsBc0APCehZ9W926J6fxH380K9EURXe_Q@mail.gmail.com>
References: <1419245944-2424-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419245944-2424-7-git-send-email-ard.biesheuvel@linaro.org>
 <20150107120608.GJ3827@bivouac.eciton.net>
 <CAKv+Gu_k0_anqvm24P8J4WaMrFLMxOhQETAfUb6xmzaJ+Z2vBQ@mail.gmail.com>
 <20150107122515.GK3827@bivouac.eciton.net>
 <CAKv+Gu-aRkoRj5zVXrsBc0APCehZ9W926J6fxH380K9EURXe_Q@mail.gmail.com>
Message-ID: <20150107125639.GL3827@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 12:30:27PM +0000, Ard Biesheuvel wrote:
> >> >> +     kernel_neon_begin();    /* disables preemption */               \
> >> >
> >> > Same nitpick.
> >> >
> >>
> >> Is there anything wrong with that?
> >
> > I said nitpick.
> >
> > My (very minor) objection is that a (very reasonable) comment is added
> > to existing functionality by a patch that adds new functionality. It
> > makes the git blame/praise output less clear.
> >
> >> Would you prefer the comment to be on a separate line?
> >
> > I would _prefer_ the comments to be a separate patch.
> > But again, a nitpick.
> >
> 
> Well, adding the comment is relevant to this patch, as we need to
> disable preemption now before switching to the new address space. In
> fact, it might be better even to drop the comment, and add an explicit
> (if redundant) preempt_disable/preempt_enable pair.

That would be more clear, yes.

/
    Leif
