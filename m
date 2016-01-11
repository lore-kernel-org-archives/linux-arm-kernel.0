From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 11 Jan 2016 12:35:47 +0200
Subject: [PATCH v3 3/3] checkpatch: add virt barriers
In-Reply-To: <1452466336.7773.46.camel@perches.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
 <1452454200-8844-4-git-send-email-mst@redhat.com>
 <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
 <1452466336.7773.46.camel@perches.com>
Message-ID: <20160111123423-mutt-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 10, 2016 at 02:52:16PM -0800, Joe Perches wrote:
> On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
> > On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > Add virt_ barriers to list of barriers to check for
> > > presence of a comment.
> []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > > @@ -5133,7 +5133,8 @@ sub process {
> > > ????????????????}x;
> > > ????????????????my $all_barriers = qr{
> > > ????????????????????????$barriers|
> > > -???????????????????????smp_(?:$smp_barrier_stems)
> > > +???????????????????????smp_(?:$smp_barrier_stems)|
> > > +???????????????????????virt_(?:$smp_barrier_stems)
> > 
> > Sorry I'm late to the party here, but would it make sense to write this as:
> > 
> > (?:smp|virt)_(?:$smp_barrier_stems)
> 
> Yes.  Perhaps the name might be better as barrier_stems.
> 
> Also, ideally this would be longest match first or use \b
> after the matches so that $all_barriers could work
> successfully without a following \s*\(
> 
> my $all_barriers = qr{
> 	(?:smp|virt)_(?:barrier_stems)|
> 	$barriers)
> }x;
> 
> or maybe add separate $smp_barriers and $virt_barriers
> 
> <shrug>  it doesn't matter much in any case

OK just to clarify - are you OK with merging the patch as is?
Refactorings can come as patches on top if required.

-- 
MST
