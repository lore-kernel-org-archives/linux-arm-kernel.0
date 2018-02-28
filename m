From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Feb 2018 09:24:59 +0100
Subject: [PATCH 0/3] Allwinner sunxi message box support
In-Reply-To: <20180228022714.30068-1-samuel@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
Message-ID: <20180228082459.o3juhfiml3logxwl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 27, 2018 at 08:27:11PM -0600, Samuel Holland wrote:
> This series adds support for the "hardware message box" in recent
> Allwinner sunxi SoCs, used for communication with the ARISC management
> processor (the platform's equivalent of the ARM SCP). The end goal is to
> use the arm_scpi driver as a client, communicating with firmware running
> on the ARISC CPU.
> 
> This driver has been tested with the base arm_scpi driver (which sends
> the SCPI_CMD_SCPI_CAPABILITIES command at probe time) and an in-progress
> firmware application running on the ARISC CPU. Because no firmware for
> the other end of the mailbox is complete at the moment, I have not
> included changes to the SoC device trees.

This is not directly related to this series, but what is your end goal
with regard to SCPI? What features do you expect to have there?

I'm asking because last time we discussed this, SCPI wasn't able to
abstract all the features the PMIC provides, and thus Linux needed to
still be able to access it.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180228/374eae6a/attachment.sig>
