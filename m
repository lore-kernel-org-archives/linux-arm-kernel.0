From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 14 Jul 2017 16:30:40 +0200
Subject: Porting a custom interrupt handler from kernel 2.6.25 to 3.16.45
In-Reply-To: <CAHumR2L95HSyXEsFtxMwAe1454og5EcsJk70ZaMOgdwQ5QGJHQ@mail.gmail.com>
References: <CAHumR2+WR3Fdtft8xrPfcT3-dpKqCL__aaEc6qri3N5-x0yCXw@mail.gmail.com>
 <20170713160625.GB27801@lunn.ch>
 <CAHumR2LazFFmmNNKJ=KrEjt7iCgrKewkdzO6ww7RtLU+wWTFoA@mail.gmail.com>
 <20170713173545.GE31807@n2100.armlinux.org.uk>
 <CAHumR2+5qWG5TTqS47PdtrQfu2N+B7x+gtmq85VL5NZj5X2-tA@mail.gmail.com>
 <20170714084831.GG31807@n2100.armlinux.org.uk>
 <CAHumR2L95HSyXEsFtxMwAe1454og5EcsJk70ZaMOgdwQ5QGJHQ@mail.gmail.com>
Message-ID: <20170714143040.GF21743@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In the end Russell, I thank you once more for your kind help and I
> will try to re-factor the existing code to fit into the framework, the
> existing stuff was looking strange to me as well, but lacking an
> overview of the architecture lead me to ask this noob questions.

Hi Mircea

Things are probably a lot easier if your custom interrupt controller
is daisy-chained off a standard interrupt controller. If it is, you
don't need to touch this low level code. No hacks are needed, and you
probably get portable code.

      Andrew
