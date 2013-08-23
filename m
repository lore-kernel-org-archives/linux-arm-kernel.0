From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Aug 2013 09:36:13 +0200
Subject: [PATCH 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM
In-Reply-To: <20130822062610.GR31036@pengutronix.de>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
 <1473340.OXSHEp7d4P@flatron>
 <1DD289F6464F0949A2FCA5AA6DC23F827D2244@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130822062610.GR31036@pengutronix.de>
Message-ID: <20130823073612.GB3535@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 08:26:10AM +0200, Sascha Hauer wrote:
> On Thu, Aug 22, 2013 at 02:55:42AM +0000, Xiubo Li-B47053 wrote:
> > Hi Tomasz,
> > 
> > Thanks for your comments.
> > 
> > 
> > > Could you explain meaning of this property more precisely? I'm interested
> > > especially how is this related to the PWM IP block and boards.
> > > 
> > 
> > Yes.
> > There are 8 channels most. While the pinctrls of 4th and 5th channels could be
> > used by uart's Rx and Tx, then these 2 channels won't be used for pwm output,
> > so there will be 6 channels available by the pwm.
> > Thus, the pwm chip will register only 6 pwms(6 channels) most("fsl,pwm-channel-orders
> > = {0 1 2 3 6 7}").And also the "fsl,pwm-channel-number" will be 6.
> 
> If the chip has eight PWMs I would register all of them. If some of them
> are not routed out by the pinmux then just nothing happens if you use
> them. In a sane devicetree they won't be referenced anyway when they are
> not routed out of the SoC.

In that case, shouldn't this be hooked up to the pinctrl subsystem as
well? As I understand the above, the logical thing would be for each PWM
channel's .request() operation to configure the pinmuxing appropriately.
And if it can't be configured as necessary then .request() should return
an error (or propagate the error from the pinctrl subsystem).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/be8cb051/attachment-0001.sig>
