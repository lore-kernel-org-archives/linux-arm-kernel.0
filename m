From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Thu, 3 Dec 2009 12:45:03 -0200
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <4B16D861.6090307@warmcat.com>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
	<4B16C185.80905@warmcat.com>
	<37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
	<4B16D861.6090307@warmcat.com>
Message-ID: <37367b3a0912030645m12db4f12j7991081e7d2bca00@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy

On 12/2/09, Andy Green <andy@warmcat.com> wrote:
> It's more a question about what that input on the PHY chip sees during
> powerup / reset... it needs to be nicely and definitely high the whole
> time so it will ignore what happens then.  Is it pulled up, or just
> connected to the iMX GPIO?  iMX GPIO alone may not be enough.  They
> mostly default to 100K pullup but even that may not be enabled early in
> the powerup action.
>

The CS_N pin is connected directly to GPIO (PA24) with no pull-up.

> A 10K to your IO voltage rail on CS_N solved it for the LiteKIT and on
> the boards we have made.
>

I place a 10K resistor to pull-up and changed CS_N to low at usb
platform init and it worked fine!

Thank you very much!

Best Regards,

Alan
