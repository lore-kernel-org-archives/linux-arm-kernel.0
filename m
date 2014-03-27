From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 27 Mar 2014 01:55:04 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Add USB Host1 support
In-Reply-To: <d8d20dd127334e76b14cc7e094aac4ad@BL2PR03MB226.namprd03.prod.outlook.com>
References: <1395750922-3244-1-git-send-email-festevam@gmail.com>
 <07405bf6fc4841d5b0d22c07c582acb9@BL2PR03MB226.namprd03.prod.outlook.com>
 <CAOMZO5Da9poOv8KqCsSxnjs4eZkVbRPCmnJCj-OX3ps8=+y+Ww@mail.gmail.com>
 <26dd7d7d9b5f481588848b0fdd65fbbb@BL2PR03MB226.namprd03.prod.outlook.com>
 <2DF5040C00EDCD438915E297DC199E925263C860@HSV-MB002.huntsville.ads.sparta.com>
 <d8d20dd127334e76b14cc7e094aac4ad@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <CAOMZO5AyWntV8EJxSQ7X0KZ0Ecboi7Q1hw=SuDgjJ02Cfp=Bbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, Mar 27, 2014 at 12:20 AM, Peter Chen <Peter.Chen@freescale.com> wrote:

> The ulpi phy driver still has not device tree version, so you can't
> find related driver.
>
> So, the default ulpi configuration at imx5-bbg board (3317 ulpi phy on it)
> works fine according to you and Fabio's test.
> The current situation is: nop phy driver can be used due to default configuration
> can be used. But in fact, your phy at host 1 is ulpi, but ulpi driver is lack of
> device tree support.
>
> Let Shawn decide whether it can be accept or not.

>From drivers/usb/phy/phy-generic.c:

" * NOP USB transceiver for all USB transceiver which are either built-in
 * into USB IP or which are mostly autonomous."

The USB PHY 3317 falls into the 'mostly automous', so that's why it
works fine with this driver.

mx27 also uses 'usb-nop-xceiv' on the ULPI PHY, so I don't see any
issue in doing the same for mx51.

I have sent a v2 for this series.

Regards,

Fabio Estevam
