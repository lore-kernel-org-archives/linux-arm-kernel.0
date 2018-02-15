From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Feb 2018 11:43:37 +0100
Subject: [PATCH V2] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <CAMuHMdXxPk=78D-hFrZvsByCEqh=+JY8C0iCdDy8FzTBPxnKDQ@mail.gmail.com>
References: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVO7sxRjj7h=ar+bA8B3Art=Yyyr66cRqC30pw3Zz+Vag@mail.gmail.com>
 <20180215101944.qtiquqqhgmg3gbrt@katana>
 <CAMuHMdXxPk=78D-hFrZvsByCEqh=+JY8C0iCdDy8FzTBPxnKDQ@mail.gmail.com>
Message-ID: <20180215104337.ewzggtcm6usdlpnt@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > It sends per device, so unless there is a device named "da9210" at
> > addr 0x70, nothing will happen? Am I missing something?
> 
> As soon as one of the affected devices is instantiated, it has to shut up
> all devices. This is done by sending the whole da9xxx_msgs[] array,
> which needs modification now we have boards with two or three devices.

Ah, I missed the "done = true;" part in remove

Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180215/d734cc8c/attachment.sig>
