From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Feb 2014 10:55:44 +0100
Subject: [PATCH v2 0/5] ARM: sun6i: Add support for the A31 I2C controller
In-Reply-To: <20140127150312.GN3867@lukather>
References: <1389609293-2824-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140127150312.GN3867@lukather>
Message-ID: <20140206095544.GF3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 04:03:12PM +0100, Maxime Ripard wrote:
> Hi Wolfram,
> 
> On Mon, Jan 13, 2014 at 11:34:48AM +0100, Maxime Ripard wrote:
> > Hi everyone,
> > 
> > This patchset adds support the A31 i2c controller. This is mostly the
> > same controller as the one found in the other Allwinner SoCs, except
> > for the interrupts acking.
> > 
> > On the other SoCs using this driver, the interrupts are acked by
> > clearing the INT_FLAG bit in the control register, while on the A31,
> > the interrupt is acked by writing that bit into the control register.
> > 
> > The other difference is that the I2C IP is maintained in reset by a
> > reset controller, so we're adding optionnal support for the reset
> > framework in the driver to deassert the device from reset.
> 
> Do you have any comments on this?

Ping?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140206/34c79c1b/attachment.sig>
