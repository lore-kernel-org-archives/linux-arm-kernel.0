From: augulis.darius@gmail.com (Darius Augulis)
Date: Wed, 27 Feb 2013 16:43:22 +0200
Subject: [PATCH v10 6/8] usb: chipidea: imx: add internal vbus regulator
 control
In-Reply-To: <20130227083610.GK8016@arwen.pp.htv.fi>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-7-git-send-email-peter.chen@freescale.com>
 <20130227075510.GB8016@arwen.pp.htv.fi>
 <20130227080735.GH1906@pengutronix.de>
 <20130227081313.GI20402@nchen-desktop>
 <20130227083610.GK8016@arwen.pp.htv.fi>
Message-ID: <CAEYLNCpNfNtpmGL-POaJ=3HJpnPnK9+vJvJ_g8_jZcmqqy=XRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi balbi,

actually no. I don't work with this hardware any more and don't have
free time to support it.
Please feel free to remove it if it breaks other things.

Darius.


On Wed, Feb 27, 2013 at 10:36 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi Darius,
>
> On Wed, Feb 27, 2013 at 04:13:14PM +0800, Peter Chen wrote:
>> On Wed, Feb 27, 2013 at 09:07:35AM +0100, Sascha Hauer wrote:
>> > On Wed, Feb 27, 2013 at 09:55:10AM +0200, Felipe Balbi wrote:
>> > > Hi,
>> > >
>> > > On Wed, Feb 27, 2013 at 02:33:17PM +0800, Peter Chen wrote:
>> > > > - For host, the vbus should always be on.
>> > > > - For otg, the vbus is off defaultly, the vbus needs to be
>> > > > turned on/off when usb role switches.
>> > > >
>> > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
>> > >
>> > > one quick question, if chipidea already has an imx glue layer, can I
>> > > delete the broken imx_udc ? It doesn't even compile and it's including
>> > > headers which don't exist.
>> >
>> > This driver handles i.MX1. This one has a gadget only core which is not
>> > chipidea compatible. You should ping Darius Augulis <augulis.darius@gmail.com>
>> > if he is willing to put some love into the driver.
>>
>> Sascha is correct.
>
> do you plan to put any work on drivers/usb/gadget/imx_udc.c ? It doesn't
> even compile since it includes headers which don't exist (and no,
> simply removing the include doesn't help).
>
> If nobody is going to work on that driver, I'm thinking about scheduling
> it for removal. We can't keep such drivers that nobody cares (and just
> break tree compilation) around.
>
> --
> balbi
