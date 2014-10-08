From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 08 Oct 2014 22:11:59 +0400
Subject: [PATCH v3 2/3] ARM: shmobile: koelsch: enable HS-USB
In-Reply-To: <20141008180852.GK22688@saruman>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
 <8674731.7YYzQeH0h1@wasted.cogentembedded.com>
 <20141008180513.GJ22688@saruman> <54357D76.4050104@cogentembedded.com>
 <20141008180852.GK22688@saruman>
Message-ID: <54357E6F.1080702@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2014 10:08 PM, Felipe Balbi wrote:

>>>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

>>>> Enable HS-USB device for the Koelsch board, defining the GPIO that the driver
>>>> should check when probing (which is the ID output from MAX3355 OTG chip).

>>>> Note that there will be pinctrl-related error messages if both internal PCI
>>>> and HS-USB drivers are enabled but they should be just ignored.

>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>> [Sergei: added pin function/group and prop, moved device node, fixed summary,
>>>> added changelog]
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>>> ---
>>>> Changes in version 3:
>>>> - added pinctrl-related properties;

>>> did you miss pinctrl here ?

>>      No, AFAICS. Or what do you mean?

> usb0_pins doesn't appear to be defined anywhere.

    They are defined in the same file, just not in this patch. If you're 
looking at some of the USB trees or Linus' tree, the corresponding patch just 
hasn't hit them yet, it's in renesas.git ATM.

WBR, Sergei
