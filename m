From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 11 Jan 2016 12:56:35 +0200
Subject: [PATCH v3 3/3] checkpatch: add virt barriers
In-Reply-To: <CAGRGNgU7=vNXZbgSwLs+bBueX1+rKACCRMi74hM+jP8MaX+-WA@mail.gmail.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
 <1452454200-8844-4-git-send-email-mst@redhat.com>
 <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
 <1452466336.7773.46.camel@perches.com>
 <20160111123423-mutt-send-email-mst@redhat.com>
 <CAGRGNgU7=vNXZbgSwLs+bBueX1+rKACCRMi74hM+jP8MaX+-WA@mail.gmail.com>
Message-ID: <20160111124509-mutt-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 09:40:18PM +1100, Julian Calaby wrote:
> Hi Michael,
> 
> On Mon, Jan 11, 2016 at 9:35 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Sun, Jan 10, 2016 at 02:52:16PM -0800, Joe Perches wrote:
> >> On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
> >> > On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > > Add virt_ barriers to list of barriers to check for
> >> > > presence of a comment.
> >> []
> >> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> >> []
> >> > > @@ -5133,7 +5133,8 @@ sub process {
> >> > >                 }x;
> >> > >                 my $all_barriers = qr{
> >> > >                         $barriers|
> >> > > -                       smp_(?:$smp_barrier_stems)
> >> > > +                       smp_(?:$smp_barrier_stems)|
> >> > > +                       virt_(?:$smp_barrier_stems)
> >> >
> >> > Sorry I'm late to the party here, but would it make sense to write this as:
> >> >
> >> > (?:smp|virt)_(?:$smp_barrier_stems)
> >>
> >> Yes.  Perhaps the name might be better as barrier_stems.
> >>
> >> Also, ideally this would be longest match first or use \b
> >> after the matches so that $all_barriers could work
> >> successfully without a following \s*\(
> >>
> >> my $all_barriers = qr{
> >>       (?:smp|virt)_(?:barrier_stems)|
> >>       $barriers)
> >> }x;
> >>
> >> or maybe add separate $smp_barriers and $virt_barriers
> >>
> >> <shrug>  it doesn't matter much in any case
> >
> > OK just to clarify - are you OK with merging the patch as is?
> > Refactorings can come as patches on top if required.
> 
> I don't really care either way, I was just asking if it was possible.
> If you don't see any value in that change, then don't make it.
> 
> Thanks,
> 
> -- 
> Julian Calaby
> 
> Email: julian.calaby at gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/

OK, got it, thanks.

I will rename smp_barrier_stems to barrier_stems since
this doesn't need too much testing.

I'd rather keep the regex code as is since changing it requires
testing.  I might play with it some more in the future
but I'd like to merge it in the current form to help make
sure __smp barriers are not misused.

I'll post v4 now - an ack will be appreciated.
-- 
MST
