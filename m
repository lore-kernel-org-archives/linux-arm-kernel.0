From: lantianyu1986@gmail.com (Tianyu Lan)
Date: Sun, 14 Oct 2018 20:57:22 +0800
Subject: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
In-Reply-To: <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
 <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
Message-ID: <CAOLK0pxC9S7YzoC-YmE7bw2VyPEZfxZSCOW+hW+t3Mi8V6Y-RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liran & Thomas:
              Thanks for your review.


On Sun, Oct 14, 2018 at 5:20 PM Liran Alon <liran.alon@oracle.com> wrote:
>
>
>
> > On 14 Oct 2018, at 11:16, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sun, 14 Oct 2018, Liran Alon wrote:
> >>> On 13 Oct 2018, at 17:53, lantianyu1986 at gmail.com wrote:
> >>>
> >>> +
> >>> +static inline bool kvm_available_flush_tlb_with_range(void)
> >>> +{
> >>> +   return kvm_x86_ops->tlb_remote_flush_with_range;
> >>> +}
> >>
> >> Seems that kvm_available_flush_tlb_with_range() is not used in this patch?
> >
> > What's wrong with that?
> >
> > It provides the implementation and later patches make use of it. It's a
> > sensible way to split patches into small, self contained entities.
> >
> > Thanks,
> >
> >       tglx
> >
>
> I guess it?s a matter of taste, but I prefer to not add dead-code for patches
> in order for each commit to compile nicely without warnings of declared and unused functions.
> I would prefer to just add this utility function on the patch that actually use it.
>
> -Liran
>

Normally, I also prefer to put the function definition into the patch
which use it.
But the following patch "KVM: Replace old tlb flush function with new
one to flush a specified range"
and other patches which use new functions will change a lot of places.
It's not friendly for review and
so I split them into pieces.
--
Best regards
Tianyu Lan
