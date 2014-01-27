From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jan 2014 16:03:12 +0100
Subject: [PATCH v2 0/5] ARM: sun6i: Add support for the A31 I2C controller
In-Reply-To: <1389609293-2824-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1389609293-2824-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140127150312.GN3867@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Jan 13, 2014 at 11:34:48AM +0100, Maxime Ripard wrote:
> Hi everyone,
> 
> This patchset adds support the A31 i2c controller. This is mostly the
> same controller as the one found in the other Allwinner SoCs, except
> for the interrupts acking.
> 
> On the other SoCs using this driver, the interrupts are acked by
> clearing the INT_FLAG bit in the control register, while on the A31,
> the interrupt is acked by writing that bit into the control register.
> 
> The other difference is that the I2C IP is maintained in reset by a
> reset controller, so we're adding optionnal support for the reset
> framework in the driver to deassert the device from reset.

Do you have any comments on this?

Thanks,
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/4998546e/attachment-0001.sig>
