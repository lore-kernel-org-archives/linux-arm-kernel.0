From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 10 Apr 2014 22:46:47 +0400
Subject: [PATCH] ARM: shmobile: r8a7790: link PCI USb devices to USB PHY
In-Reply-To: <534674B5.6080706@cogentembedded.com>
References: <201404092318.26231.sergei.shtylyov@cogentembedded.com>
 <CANqRtoQeuT=Q9PRYNMqA079gjb1VkwgvcDmsWKxjzSVxcVfeWw@mail.gmail.com>
 <534674B5.6080706@cogentembedded.com>
Message-ID: <5346E717.4040507@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2014 02:38 PM, Sergei Shtylyov wrote:

>> Thanks for this patch, good to see that the relationship between the
>> USB Host and the PHY is described via DT.

>> This patch seems to cover USB0 and USB2 that both require special
>> control in the PHY. How about USB1? Can you explain about the reason
>> why you omit that?

>     Because the driver does nothing for USB1 anyway.

    Looks like I should have tested that last minute change: kernel oopses due 
to NULL pointer dereference somewhere in phy_get() once it gets called for 
EHCI on the channel #1. At least doesn't seem to be my mistake...

WBR, Sergei
