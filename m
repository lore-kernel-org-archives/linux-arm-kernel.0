From: balbi@ti.com (Felipe Balbi)
Date: Mon, 11 May 2015 12:02:23 -0500
Subject: [PATCH 1/2] arm: boot: dts: am4372: add operating points
In-Reply-To: <CAGo_u6oQ_uzO4B4ezC-Vi8_FQZWH49+6fbutdVgP5s0fL3MhrA@mail.gmail.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <554D17F3.7090008@ti.com> <554D18AB.6060901@ti.com>
 <20150508202439.GA25459@saruman.tx.rr.com>
 <554FF686.5050704@ti.com>
 <20150511151930.GA19183@saruman.tx.rr.com>
 <CAGo_u6oQ_uzO4B4ezC-Vi8_FQZWH49+6fbutdVgP5s0fL3MhrA@mail.gmail.com>
Message-ID: <20150511170223.GC22558@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Mon, May 11, 2015 at 11:46:13AM -0500, Nishanth Menon wrote:
> On Mon, May 11, 2015 at 10:19 AM, Felipe Balbi <balbi@ti.com> wrote:
> >
> >> in my opinion, doing a temporary hack in upstream kernel is not an
> >> elegant approach. I suggest helping review and approving Viresh's new
> >
> > however this is not a hack, right ? If we get rid of OPP_NITRO and
> > OPP_TURBO, then we will more than likely always be dealing with safe
> > OPPs (yeah, I need to confirm this since it's not on public TRM, so as
> > of now, take this statement with a grain of salt :-), moreover, even
> > though we're trying to change opp bindings, the current situation is
> > still very much accepted and will remain valid even after changing
> > binding :-)
> 
> yes - if we do have a documented subset of OPPs that are valid for all
> "variants" of AM437x, we could add that in using the legacy bindings,
> but, we will have to do a transition over to the new bindings when
> they are finalized to support all OPPs appropriately.

sounds fair to me.

> > Not to mention that people using AM43xx today might be using it under
> > invalid OPPs and decreasing silicon life; I'd assume that's a very
> > urgent detail to sort out.
> 
> While I do agree that there is always a debate between fixing things
> in kernel for bootloader issues, but it does not mean that we should
> just postpone fixing the bootloader in this case - since, at this very
> moment, we are already in broken configuration - example sitting on a
> bootloader shell does have the same impact we have at this time.

agreed, I'll cook up a patch for bootloader too.

> Lets try to help Viresh in getting his series sorted out meanwhile -
> maybe others can help as well :(

sure.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150511/b970e4dc/attachment.sig>
