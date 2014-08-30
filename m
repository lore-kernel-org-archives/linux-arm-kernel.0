From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Aug 2014 22:33:49 +0100
Subject: [PATCH RFC v2 3/8] component: add support for component match
 array
In-Reply-To: <CAAQKjZOf-UoONHFf=6W4j4rXuo0nSJrhK_QesxNR55CEF7XONw@mail.gmail.com>
References: <20140624192830.GC20555@n2100.arm.linux.org.uk>
 <E1WzWOy-0007zc-36@rmk-PC.arm.linux.org.uk>
 <CA+gwMcdO5P-Yu+-FeHHGxkKwObsATL-ThVDwmEm2_cZ3enUXPQ@mail.gmail.com>
 <20140626144601.GS32514@n2100.arm.linux.org.uk>
 <20140701142210.GS32514@n2100.arm.linux.org.uk>
 <CAAQKjZOf-UoONHFf=6W4j4rXuo0nSJrhK_QesxNR55CEF7XONw@mail.gmail.com>
Message-ID: <20140830213349.GE30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 12:26:39AM +0900, Inki Dae wrote:
> 2014-07-01 23:22 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Thu, Jun 26, 2014 at 03:46:01PM +0100, Russell King - ARM Linux wrote:
> >> On Thu, Jun 26, 2014 at 02:34:17PM +0200, Philipp Zabel wrote:
> >> > Hi Russell,
> >> >
> >> > On Tue, Jun 24, 2014 at 9:29 PM, Russell King
> >> > <rmk+kernel@arm.linux.org.uk> wrote:
> >> > [...]
> >> > > +/*
> >> > > + * Add a component to be matched.
> >> > > + *
> >> > > + * The match array is first created or extended if necessary.
> >> > > + */
> >> > > +void component_match_add(struct device *dev, struct component_match **matchptr,
> >> > > +       int (*compare)(struct device *, void *), void *compare_data)
> >> > > +{
> >> > > +       struct component_match *match = *matchptr;
> >> > > +
> >> > > +       if (IS_ERR(match))
> >> > > +               return;
> >> > > +
> >> > > +       if (!match || match->num == match->alloc) {
> >> > > +               size_t new_size = match ? match->alloc + 16 : 15;
> >> > > +
> >> > > +               match = component_match_realloc(dev, match, new_size);
> >> > > +
> >> > > +               *matchptr = match;
> >> > > +
> >> > > +               if (IS_ERR(match))
> >> > > +                       return;
> >> > > +       }
> >> > > +
> >> > > +       match->compare[match->num].fn = compare;
> >> > > +       match->compare[match->num].data = compare_data;
> >> > > +       match->num++;
> >> > > +}
> >> >
> >> > component_match_add should be exported.
> >>
> >> Fixed, thanks.
> >
> > As there's no further comments, and Inki Dae has not responded, I'm
> 
> It's has been just a week. I will check and look into your patch
> series. I think Exynos drm should also be considered for the use of
> component match array.

It has now been almost two months.  What's happening on this?

Please note that I'm planning to push the rest of the component updates
during the next merge window, which will result in unconverted drivers
breaking.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
