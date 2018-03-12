From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Mar 2018 10:02:47 +0000
Subject: PSCI version misdetection
In-Reply-To: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
References: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
Message-ID: <20180312100247.qd2cph56bhypzwp7@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2018 at 01:46:30PM -0300, Fabio Estevam wrote:
> Hi,
> 
> On a  imx7d-sdb board running 4.14-rc6:
> 
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv65535.65535 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> 
> The PSCI version seems to be misdetected.
> 
> CONFIG_ARMV7_PSCI_1_0 is passed in U-Boot, so I would expect to see:
> 
> psci: PSCIv1.0 detected in firmware.
> 
> Any ideas?

It sounds like U-Boot hasn't implemented the PSCI_VERSION call, and is
returning NOT_IMPLEMENTED (-1). If so, this is not a conforming PSCI 1.0
implementation, as PSCI_VERSION is mandatory.

AFAICT, The default implementation in arch/arm/cpu/armv7/psci.S returns
NOT_SUPPORTED.

Where does the implementation for imx7d-sdb live? Is this upstream?

Thanks,
Mark.
