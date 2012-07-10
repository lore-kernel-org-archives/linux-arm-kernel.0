From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 11:26:32 +0200
Subject: [PATCH] IIO: Add basic MXS LRADC driver
In-Reply-To: <201207101120.52892.jbe@pengutronix.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
 <201207091203.09371.marex@denx.de> <201207101120.52892.jbe@pengutronix.de>
Message-ID: <201207101126.32778.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juergen Beisert,

> Hi Marek,
> 
> > > When I try to compile
> > > your code I get:
> > > 
> > > drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error:
> > > linux/iio/triggered_buffer.h: No such file or directory
> > 
> > You need this patches:
> >     iio:kfifo_buf Take advantage of the fixed record size used in IIO
> >     iio: kfifo - add poll support.
> > 
> > And use latest -next.
> 
> Thanks for the hints. Now it compiles and the driver seems to work.
> 
> One thing I do not understand: It does not matter what channel I read
> ('in_voltage*_raw'), only interrupt 16 ('mxs-lradc-channel0') counts up.
> Intended?
> Or did I a mistake by adding interrupt numbers "<13 14 15 16 17 18 19 20 21
> 22 23 24 25>" to the corresponding device tree entry?


They're wrong

lradc at 80050000 {
        compatible = "fsl,imx28-lradc";
        reg = <0x80050000 2000>;
        interrupts = <10 14 15 16 17 18 19
                        20 21 22 23 24 25>;
        status = "disabled";
};


> Regards,
> Juergen

Best regards,
Marek Vasut
