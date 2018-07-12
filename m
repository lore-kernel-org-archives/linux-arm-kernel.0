From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 12 Jul 2018 03:46:46 +0000
Subject: [PATCH V4 0/5] soc: imx: add scu firmware api support
In-Reply-To: <24505e51-3a5d-4f34-7ba6-262e118d070e@arm.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <24505e51-3a5d-4f34-7ba6-262e118d070e@arm.com>
Message-ID: <AM0PR04MB42113AC1D31A193E40F259CC80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Thursday, July 12, 2018 12:49 AM
> To: A.s. Dong <aisheng.dong@nxp.com>; linux-arm-
> kernel at lists.infradead.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; dongas86 at gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org; Cl?ment Faure
> <clement.faure@nxp.com>
> Subject: Re: [PATCH V4 0/5] soc: imx: add scu firmware api support
> 
> On 08/07/18 15:56, Dong Aisheng wrote:
> > Unlike the former i.MX Architectures, the new generation i.MX8 SoCs
> > (e.g. MX8QXP and MX8QM) contain a system controller which runs on a
> > dedicated Cortex-M core to provide power, clock, Pad, and resource
> > management. Communication between the host processor running an OS
> and
> > the system controller happens through a SCU protocol.
> > This patchset adds the SCU APIs which is implemented based on MU and
> > will be used by different system components.
> >
> > It mainly consists of below parts:
> > 1) MU mailbox driver
> > 1) Implementation of the IPC functions based on MUs (client side).
> >
> >
> 
> I do understand the firmware might be already released for the current
> generation of platforms, but instead of adding to the fragmentation, it would
> be good to migrated to ARM SCMI for future platforms.
> 
> This system controller communication protocol is already so fragmented (we
> have TI SCI, QCOM RPM, Nvidia Tegra BPMP, ARM SCPI and so on..
> and now this i.MX specific one added to that), the main intention of ARM
> SCMI is to stop that. The idea is for any Power Control System
> Architecture(PCSA) compliant systems or any similar systems, SCMI should
> be the standard communication protocol.

That sounds good and worth a look.
Copy SCU firmware guys if more comments.
BTW, i.MX SCU provides more services than just power related. 
Not sure if ARM SCMI can cover it.

Regards
Dong Aisheng

> 
> --
> Regards,
> Sudeep
