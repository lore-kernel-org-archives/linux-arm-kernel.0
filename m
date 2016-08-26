From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 26 Aug 2016 09:43:08 -0300
Subject: [PATCH 0/3] Add SMP support for i.MX7D
In-Reply-To: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DaL+CKQe0hOHi_Kv8Vt9y0RHyERS8ek78WebxFmjj9rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Fri, Aug 26, 2016 at 8:12 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX7D has 2 Cortex-A7 ARM cores, and it has a different GPC design
> than i.MX6, so this patch set adds a new GPCV2 driver for i.MX7D,
> and also adds runtime check in SMP code to support both Cortex-A9
> and Cortex-A7 ARM cores.
>
> With this patch set, i.MX7D can boot up SMP kernel with 2 CPUs.

Currently mx7d can boot the 2 CPUs if you use PSCI in the bootloader.

Give mainline U-Boot a try and it will boot the 2 CPUs via PSCI.

There was an attempt to add gpcv2 support at:
https://patchwork.kernel.org/patch/6919831/

, and Shawn suggested to go to the PSCI approach.

PSCI for mx7 is still missing suspend support though.

Regards,

Fabio Estevam
