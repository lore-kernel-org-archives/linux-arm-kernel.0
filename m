From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 6 Nov 2014 09:52:28 +0800
Subject: [PATCH V3 1/3] can: add can_is_canfd_skb() API
In-Reply-To: <545A5F55.7050307@hartkopp.net>
References: <1415193393-30023-1-git-send-email-b29396@freescale.com>
 <1415204533.13896.7.camel@edumazet-glaptop2.roam.corp.google.com>
 <545A5F55.7050307@hartkopp.net>
Message-ID: <20141106015226.GA7642@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 06:33:09PM +0100, Oliver Hartkopp wrote:
> On 05.11.2014 17:22, Eric Dumazet wrote:
> >On Wed, 2014-11-05 at 21:16 +0800, Dong Aisheng wrote:
> 
> >
> >This looks a bit strange to assume that skb->len == magical_value is CAN
> >FD. A comment would be nice.
> >
> 
> Yes. Due to exactly two types of struct can(fd)_frame which can be
> contained in a skb the skbs are distinguished by the length which
> can be either CAN_MTU or CANFD_MTU.
> 
> >>+static inline int can_is_canfd_skb(struct sk_buff *skb)
> >
> >static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> >
> 
> ok.
> 

Got it.

> >>+{
> 
> What about:
> 
> 	/* the CAN specific type of skb is identified by its data length */
> 

Looks good to me.
I will send a updated version with these changes.

> >>+	return skb->len == CANFD_MTU;
> >>+}
> >>+
> >>  /* get data length from can_dlc with sanitized can_dlc */
> >>  u8 can_dlc2len(u8 can_dlc);
> 
> Regards,
> Oliver
>

Regards
Dong Aisheng
