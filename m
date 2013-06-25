From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Jun 2013 20:42:34 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <CAOMZO5DFdUNm3e6+VLioFLEORYXaN2X331jOYBm7o-pE_6MYvw@mail.gmail.com>
References: <51A5A808.2070803@digi.com>
 <CAOMZO5DN6u32Udz9SxgnmpH8gtM0FzbL1fPCZ96EchSUzbBzMQ@mail.gmail.com>
 <CAOMZO5DFdUNm3e6+VLioFLEORYXaN2X331jOYBm7o-pE_6MYvw@mail.gmail.com>
Message-ID: <201306252042.34341.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Tue, Jun 25, 2013 at 11:23 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Mon, Jun 24, 2013 at 10:51 AM, Marek Vasut <marex@denx.de> wrote:
> >> Fabio, can you possibly test on MX23EVK please?
> > 
> > I never used USB gadget with chipidea driver.
> > 
> > Could you please explain what are the changes I need to do in the dts
> > file (I want to try on mx28evk first) and defconfig in order to be
> > able to test gadget? I am running today's linux-next.
> 
> I tried the following:

Merge [1] into your tree, enable USB peripheral mode for CI13xxx, enable 
ethernet gadget, adjust your DT file like this for the usb0 node:

usb0: usb at 80080000 {
        dr_mode = "peripheral";
        status = "okay";
};

And you should have gadget working.

[1] 
http://git.pengutronix.de/?p=mgr/linux.git;a=shortlog;h=refs/heads/v3.10/topic/usb-
peterchen

Best regards,
Marek Vasut
