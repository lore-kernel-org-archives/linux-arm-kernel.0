From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 22 Apr 2014 16:37:10 +0200
Subject: [PATCH RESEND] tty/serial: atmel_serial: Fix device tree
 documentation
In-Reply-To: <CACQ1gAhjrb+3Bka64QfbopvEeiU-ifm35eLYUrjwyR-3goW4QQ@mail.gmail.com>
References: <1397835904-866-1-git-send-email-richard.genoud@gmail.com>
 <CACQ1gAhjrb+3Bka64QfbopvEeiU-ifm35eLYUrjwyR-3goW4QQ@mail.gmail.com>
Message-ID: <20140422143710.GJ3461@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/04/2014 at 15:45:26 +0200, Richard Genoud wrote :
> 2014-04-18 17:45 GMT+02:00 Richard Genoud <richard.genoud@gmail.com>:
> > RTS pin is an active low pin.
> > For now, this doesn't change anything as the ACTIVE_LOW (1) flag is not
> > handled in atmel_serial, but it will be in 3.16.
> >
> > Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/serial/atmel-usart.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > index 17c1042b2df8..0dd0a5493a54 100644
> > --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > @@ -35,7 +35,7 @@ Example:
> >                 clock-names = "usart";
> >                 atmel,use-dma-rx;
> >                 atmel,use-dma-tx;
> > -               rts-gpios = <&pioD 15 0>;
> > +               rts-gpios = <&pioD 15 1>;
> >         };
> >
> >  - use DMA:
> 
> Rob,
> Does this has a chance to get to 3.15-rc3 or it's not worth it ?
> If it's not programmed for the 3.15-rc cycle, please drop it : I've
> got a patchset depending on it, and it will be in another tree.
> 

I would say that kind of change should go through Nicolas' tree or
gregkh tty tree as it is directly related to the driver.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
