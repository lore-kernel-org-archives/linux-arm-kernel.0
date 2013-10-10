From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 9 Oct 2013 23:45:30 -0400 (EDT)
Subject: [RFC v2 PATCH 1/4] ARM: add support for kernel mode NEON in
 atomic context
In-Reply-To: <CAKv+Gu_h_q0WRUo0e0kpeocgjONLDpTpWGWq=tzZhKYR8w3LyQ@mail.gmail.com>
References: <1381344634-14917-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381344634-14917-2-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.03.1310091509400.3023@syhkavp.arg>
 <CAKv+Gu_h_q0WRUo0e0kpeocgjONLDpTpWGWq=tzZhKYR8w3LyQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1310092333410.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Ard Biesheuvel wrote:

> On 9 October 2013 21:24, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Wed, 9 Oct 2013, Ard Biesheuvel wrote:
> >
> >> +static inline void __kernel_neon_begin_atomic(struct vfp_partial_state *regs)
> >> +{
> >> +     if (!in_interrupt())
> >> +             kernel_neon_begin();
> >
> > Surely you want "if (!in_atomic())" here?
> >
> >> +     else
> >> +             vfp_save_partial_state(regs);
> >> +}
> >> +
> >> +static inline void __kernel_neon_end_atomic(struct vfp_partial_state *regs)
> >> +{
> >> +     if (!in_interrupt())
> >> +             kernel_neon_end();
> >
> > Ditto.
> >
> 
> If I am reading (and understanding) the source correctly, in_atomic()
> is also true when running with preemption disabled, and in that case,
> you should be able to just do a normal preserve / lazy restore.

Hmmm...  OK I agree.


Nicolas
