From: martinayotte@gmail.com (martinayotte at gmail.com)
Date: Tue, 19 Apr 2016 11:27:16 -0700 (PDT)
Subject: [PATCH v1 1/1] add missing UARTs pins for AllWinner H3 DTS +
 add new I2C entries for AllWinner H3 DTS
In-Reply-To: <CAGb2v65dsjbpGUrJXFG35cLGnFA6uDxtgMqupBN97=8XNnO68Q@mail.gmail.com>
References: <8673D89D449742EAB9F6EBD05655A295@GirolesWin7>
 <CAGb2v67e_F1=VaY7ovzW7Whc2ToJU3YabeT-orrLTb0Pouhw_Q@mail.gmail.com>
 <21e74cd8-2ec7-4fd3-aa5c-ba4eed29a6ab@googlegroups.com>
 <CAGb2v65dsjbpGUrJXFG35cLGnFA6uDxtgMqupBN97=8XNnO68Q@mail.gmail.com>
Message-ID: <16057207-027e-4709-b5c2-61be199e5cb5@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 19, 2016 at 11:11:37 AM UTC-4, Chen-Yu Tsai wrote:
> Try to wrap lines to 80 characters or less.

Ok ! I will be more careful ...

> 1 change per patch. You are making 3 changes here. a) adding shared
> pinmux settings,
> b & c) enabling uarts and i2c busses for 2 boards.
> 
> You could split them into 1 dtsi patch adding the pinmux setting, and
> then 1 for each
> board enabling the peripherals.

Fine ! I will prepare and redo a new submit with only the DTSI for now.

> Perhaps they were enabled before the policy was enacted, or it just
> slipped through. I
> contributed to a few. But for many boards we might not have schematics
> or the actual
> device to check.

Understood ! But sometimes things are so generic, like having uart0 and not having uart1 make it looks a bit strange. Some other times having some i2c2 because of PMIC while not having i2c0 and i2c1 is also strange.

> How would you determine what the most common usage is for "development boards"?
> If the vendor explicitly designed the pins to be used one way, and even printed
> the description on the board, then you may have a valid argument. But even then,
> with the C.H.I.P., they are going with DT overlays.
> 
> It shouldn't be hard for an end user to modify the DT. And with I2C devices, it
> is almost a requirement.

Ok ! I will look if it is easier to do the rest with overlays.
