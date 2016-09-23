From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 23 Sep 2016 20:13:01 +0200
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <0fe7a310-2d2f-4fca-d698-85d66122d91c@nelint.com>
References: <troy.kisky@boundarydevices.com>
 <02afb707-65de-5101-a79b-355929c4e00b@nelint.com>
 <CANn89iLb+QJu+MYh859oAAjcLCsKRpBbzVf43yOdq+HJVtZDpQ@mail.gmail.com>
 <5ee28ee0-cf0c-bdab-1271-f17755365c13@nelint.com>
 <0fe7a310-2d2f-4fca-d698-85d66122d91c@nelint.com>
Message-ID: <20160923181301.GD22965@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Since the hardware requires longword alignment for its' DMA transfers,
> aligning the IP header will require a memcpy, right?

The vf610 FEC has an SHIFT16 bit in register ENETx_TACC, which inserts
two padding bits on transmit. ENETx_RACC has the same.

What about your hardware?

     Andrew
