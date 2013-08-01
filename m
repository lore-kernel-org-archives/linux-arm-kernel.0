From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 21:33:43 +0100
Subject: [PATCH V2 3/3] ethernet: Convert mac address uses of 6 to ETH_ALEN
In-Reply-To: <CAOesGMhmxJTDjcPeD4b1FvRsbP8df369F01SQBK6dk4nXmRGjA@mail.gmail.com>
References: <cover.1375387593.git.joe@perches.com>
 <4170130535e4ea14c66f8510042577be21941f4d.1375387593.git.joe@perches.com>
 <CAOesGMhmxJTDjcPeD4b1FvRsbP8df369F01SQBK6dk4nXmRGjA@mail.gmail.com>
Message-ID: <20130801203343.GG23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 01:31:09PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Thu, Aug 1, 2013 at 1:14 PM, Joe Perches <joe@perches.com> wrote:
> 
> > diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.h b/drivers/net/ethernet/pasemi/pasemi_mac.h
> > index e2f4efa..649fdb4 100644
> > --- a/drivers/net/ethernet/pasemi/pasemi_mac.h
> > +++ b/drivers/net/ethernet/pasemi/pasemi_mac.h
> > @@ -79,11 +79,11 @@ struct pasemi_mac {
> >         int             last_cs;
> >         int             num_cs;
> >         u32             dma_if;
> > -       u8              type;
> >  #define MAC_TYPE_GMAC  1
> >  #define MAC_TYPE_XAUI  2
> >
> > -       u8              mac_addr[6];
> > +       u8              mac_addr[ETH_ALEN];
> > +       u8              type;
> 
> Just promote 'type' to u32 instead, saves you from moving the #defines
> down, etc, etc.

There's a more fundamental question which has to be asked: what is the
point of moving that in the first place?
