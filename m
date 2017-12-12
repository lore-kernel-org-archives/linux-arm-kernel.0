From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Dec 2017 10:40:30 +0000
Subject: [PATCH v5 15/30] arm64/sve: Signal handling support
In-Reply-To: <CAGXu5j+2MNOnAfstr8RyD0Orrt37ewL8uE2N8e3fL--fNPs3TQ@mail.gmail.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
 <1509465082-30427-16-git-send-email-Dave.Martin@arm.com>
 <CAGXu5jJgsAg1VBMbx=mV3ep4hzs+1G46Sow4eeFqCK31b_sORA@mail.gmail.com>
 <20171207104948.GE31900@arm.com>
 <CAGXu5jLO6tHm-mCPBo-csCw--+_jhLfGD_sHXCkFjmyvdame=g@mail.gmail.com>
 <20171211140720.GE2141@arm.com>
 <CAGXu5j+2MNOnAfstr8RyD0Orrt37ewL8uE2N8e3fL--fNPs3TQ@mail.gmail.com>
Message-ID: <20171212104030.GG28301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 11:23:09AM -0800, Kees Cook wrote:
> On Mon, Dec 11, 2017 at 6:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Dec 07, 2017 at 10:50:38AM -0800, Kees Cook wrote:
> >> My question is mainly: why not just use copy_*() everywhere instead?
> >> Having these things so spread out makes it fragile, and there's very
> >> little performance benefit from using __copy_*() over copy_*().
> >
> > I think that's more of a general question. Why not just remove the __
> > versions from the kernel entirely if they're not worth the perf?
> 
> That has been something Linus has strongly suggested in the past, so
> I've kind of been looking for easy places to drop the __copy_*
> versions. :)

Tell you what then: I'll Ack the arm64 patch if it's part of a series
removing the thing entirely :p

I guess we'd still want to the validation of the whole sigframe though,
so we don't end up pushing half a signal stack before running into an
access_ok failure?

Will
