From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Aug 2015 03:28:40 -0700
Subject: [PATCH v2 1/3] mailbox/omap: Add ti, mbox-send-noirq quirk to fix
 AM33xx CPU Idle
In-Reply-To: <1437166592-25378-2-git-send-email-d-gerlach@ti.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
 <1437166592-25378-2-git-send-email-d-gerlach@ti.com>
Message-ID: <20150805102840.GA16878@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [150717 13:59]:
> --- a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> +++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> @@ -75,6 +75,14 @@ data that represent the following:
>      Cell #3 (usr_id)  - mailbox user id for identifying the interrupt line
>                          associated with generating a tx/rx fifo interrupt.
>  
> +Optional Properties:
> +--------------------
> +- ti,mbox-send-noirq:   Quirk flag to allow the client user of this sub-mailbox
> +                        to send messages without triggering a Tx ready interrupt,
> +                        and to control the Tx ticker. Should be used only on
> +                        sub-mailboxes used to communicate with WkupM3 remote
> +                        processor on AM33xx/AM43xx SoCs.
> +

Hmm can't you do this just by setting a flag in the device driver
based on the compatible string?

Regards,

Tony
