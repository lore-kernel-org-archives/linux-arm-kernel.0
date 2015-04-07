From: geoff@infradead.org (Geoff Levand)
Date: Tue, 07 Apr 2015 15:48:11 -0700
Subject: [PATCH 5/6] arm64/kexec: Add core kexec support
In-Reply-To: <552407F1.1040909@arm.com>
References: <cover.1426793116.git.geoff@infradead.org>
 <88216e29d97715cecac8630bc57342d0be860235.1426793116.git.geoff@infradead.org>
 <552407F1.1040909@arm.com>
Message-ID: <1428446891.11876.1.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Tue, 2015-04-07 at 17:38 +0100, Suzuki K. Poulose wrote:
> On 19/03/15 20:35, Geoff Levand wrote:
> > +static void kexec_list_flush(unsigned long kimage_head)
> > +{
> > +       void *dest;
> 
> What is the use of dest ?

dest is left over from when I had a generic list walk routine.  I'll
remove it.
 
> > +       unsigned long *entry;
> > +
> > +       for (entry = &kimage_head, dest = NULL; ; entry++) {
> > +               unsigned int flag = *entry &
> > +                       (IND_DESTINATION | IND_INDIRECTION | IND_DONE |
> > +                       IND_SOURCE);
> You could instead do :
> 
> 	flag = *entry & IND_FLAGS;

Yes, now that the patch to define IND_FLAGS has been merged.

-Geoff
