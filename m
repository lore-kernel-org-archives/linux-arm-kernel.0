From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 10 Apr 2014 14:38:45 +0400
Subject: [PATCH] ARM: shmobile: r8a7790: link PCI USb devices to USB PHY
In-Reply-To: <CANqRtoQeuT=Q9PRYNMqA079gjb1VkwgvcDmsWKxjzSVxcVfeWw@mail.gmail.com>
References: <201404092318.26231.sergei.shtylyov@cogentembedded.com>
 <CANqRtoQeuT=Q9PRYNMqA079gjb1VkwgvcDmsWKxjzSVxcVfeWw@mail.gmail.com>
Message-ID: <534674B5.6080706@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-04-2014 11:07, Magnus Damm wrote:

> Thanks for this patch, good to see that the relationship between the
> USB Host and the PHY is described via DT.

> This patch seems to cover USB0 and USB2 that both require special
> control in the PHY. How about USB1? Can you explain about the reason
> why you omit that?

    Because the driver does nothing for USB1 anyway.

> I somehow expected USB1 to be tied to the PHY via DT as well, this so
> the PHY driver can be able to disable the hardware if no ports are
> registered. In detail, I'm thinking that the register.bit
> UGCTL.CONNECT wants to be set to 0 by default but be set to 1 once one
> or more USB controllers are hooked up to the PHY.

    I don't think this bit has any sense for non-USBHS controllers. EHCI/OHCI 
drivers happily work without setting it.

WBR, Sergei
