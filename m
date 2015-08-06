From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Aug 2015 23:29:23 -0700
Subject: [PATCH v2 1/3] mailbox/omap: Add ti, mbox-send-noirq quirk to fix
 AM33xx CPU Idle
In-Reply-To: <55C22C8E.3000506@ti.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
 <1437166592-25378-2-git-send-email-d-gerlach@ti.com>
 <20150805102840.GA16878@atomide.com> <55C22C8E.3000506@ti.com>
Message-ID: <20150806062923.GN16878@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [150805 08:35]:
> Hi Tony,
> 
> On 08/05/2015 05:28 AM, Tony Lindgren wrote:
> > * Dave Gerlach <d-gerlach@ti.com> [150717 13:59]:
> >> --- a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> >> +++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> >> @@ -75,6 +75,14 @@ data that represent the following:
> >>      Cell #3 (usr_id)  - mailbox user id for identifying the interrupt line
> >>                          associated with generating a tx/rx fifo interrupt.
> >>  
> >> +Optional Properties:
> >> +--------------------
> >> +- ti,mbox-send-noirq:   Quirk flag to allow the client user of this sub-mailbox
> >> +                        to send messages without triggering a Tx ready interrupt,
> >> +                        and to control the Tx ticker. Should be used only on
> >> +                        sub-mailboxes used to communicate with WkupM3 remote
> >> +                        processor on AM33xx/AM43xx SoCs.
> >> +
> > 
> > Hmm can't you do this just by setting a flag in the device driver
> > based on the compatible string?
> 
> We can't because there can be other users like PRUSS which will use a
> sub-mailbox in a regular fashion. The compatible serves the IP and there
> can be multiple sub-mailboxes underneath it, and this quirk is needed
> only on the one that's used by the WkupM3.

OK

> Do you have any comments on this?

Up to you guys then to figure out what property is used for it then.

Regards,

Tony
