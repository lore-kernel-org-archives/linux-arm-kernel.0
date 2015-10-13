From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 13 Oct 2015 14:25:12 +0200
Subject: [PATCH v7 1/7] ARM: dts: imx: imx7d-sbd remove fixed can2-3v3
 regulator
In-Reply-To: <CAA+hA=Tuj6xTvcPB7xFi6jghBJZAMNTkMheR8HBz8-bfBdRn8g@mail.gmail.com>
References: <1443477401-17238-1-git-send-email-aalonso@freescale.com>
 <CAA+hA=Tuj6xTvcPB7xFi6jghBJZAMNTkMheR8HBz8-bfBdRn8g@mail.gmail.com>
Message-ID: <561CF828.7050609@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2015 02:04 PM, Dong Aisheng wrote:
> On Tue, Sep 29, 2015 at 5:56 AM, Adrian Alonso <aalonso@freescale.com> wrote:
>> Remove incorrect can2-3v3 fixed regulator, imx7d-sdb doesn't
>> have a dedicated can2 fixed regulator instead it shares PERI_3V3
>> fixed regulator (RT8070ZS) which is enabled by default (hardwired)
>> from pmic pfuze3000 NVCC_3V3 power rail.
>>
>> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
>> ---
>> Changes for V7: New patch in series
>>
> 
> It is a correct regulator here, but i have to admit that it's a bit confusing.
> Here the regulator is an abstract regulator which is actually used to
> control CAN
> transceiver STBY signals, it is introduced by below patch:
> commit b7c4114b07bbacfe0aee1d04ad1ade9e42309620
> Author: Fabio Estevam <fabio.estevam@freescale.com>
> Date:   Mon Jun 10 23:12:57 2013 -0300
> 
>     can: flexcan: Use a regulator to control the CAN transceiver
> 
>     Instead of using a GPIO to turn on/off the CAN transceiver, it is better to
>     use a regulator as some systems may use a PMIC to power the CAN transceiver.
> 
>     Acked-by: Shawn Guo <shawn.guo@linaro.org>
>     Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> From the commit messages, it should be likely to control the
> transceiver external suppy,
> not control signals, but it does do that unproper work currently.
> 
> Besides the unproperly handling control signals, this solution also can't handle
> multiple CAN transceiver control signals ways.

You can chain several transceivers together if you need to control more
than one GPIO line.

> I was trying to write a common transceiver driver to handling this issue.
> But get interrupted by a few other FSL official works, will resume soon.

Have a look at drivers/phy.

> I would suggest keep the regulator first until the new solution got in.

Marc


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/405f4bf0/attachment.sig>
