From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 09 Dec 2013 22:57:57 +0300
Subject: [PATCH 2/2] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <5272A98B.3030705@cogentembedded.com>
References: <201310310216.28673.sergei.shtylyov@cogentembedded.com>	<201310310219.58963.sergei.shtylyov@cogentembedded.com>
 <CANqRtoTa6-UP88146KPy9zNXNTRynBVqWZYb1k=0MK03NMJqhw@mail.gmail.com>
 <5272A98B.3030705@cogentembedded.com>
Message-ID: <52A620C5.9030600@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/31/2013 10:03 PM, I wrote:

>>> Register Ether platform device and pin data on  the  Koelsch board.
>>> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.

>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> Thanks for your patch. Just like on the Lager board we also need to
>> tie in the PHY IRQ pin.

>     Not only on the Lager board, BOCK-W also I think.

>> Polling is not good enough when the hardware
>> can do better. Can you please share your PHY IRQ plans with us?

>     It's on my agenda now -- will start after I do away with the CAN driver
> and the current Koelsch Ether support.

    I have now implemented PHY IRQ support for BOCK-W, Lager, and Koelsch 
boards (had to extend the Micrel PHY driver to recognize undocumented 
KSZ8041RNLI PHY ID for that) but I must say that the PHY interrupt doesn't get 
generated on either of the board and I don't know why yet (I can't rule out 
the INTC driver issue); that's bad news. Good news is that even this doesn't 
prevent phylib from working properly as it still polls the PHY once a second.

>> Best,

>> / magnus

WBR, Sergei
