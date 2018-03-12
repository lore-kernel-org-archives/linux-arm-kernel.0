From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Mar 2018 08:12:02 -0300
Subject: PSCI version misdetection
In-Reply-To: <20180312100247.qd2cph56bhypzwp7@salmiak>
References: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
 <20180312100247.qd2cph56bhypzwp7@salmiak>
Message-ID: <CAOMZO5BJ2GuqZS=9C6sA=JXif64OcL1gAbaxbpfdCYEGVM7ZTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Mar 12, 2018 at 7:02 AM, Mark Rutland <mark.rutland@arm.com> wrote:

> It sounds like U-Boot hasn't implemented the PSCI_VERSION call, and is
> returning NOT_IMPLEMENTED (-1). If so, this is not a conforming PSCI 1.0
> implementation, as PSCI_VERSION is mandatory.
>
> AFAICT, The default implementation in arch/arm/cpu/armv7/psci.S returns
> NOT_SUPPORTED.
>
> Where does the implementation for imx7d-sdb live? Is this upstream?

Yes, it is in mainline U-Boot.

As per this commit it would use PSCIv1.0:

http://git.denx.de/?p=u-boot.git;a=commitdiff;h=0ec3d98f76923619acfd91f93f8221e609e1e5bc;hp=04c28a7810970e404550f3510f8d9dfd90d6dc81

Thanks
