From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 17 Jun 2013 13:43:52 +0000
Subject: [PATCH v2 0/2] Remove unused voltagedomain data for AM33xx
In-Reply-To: <1371474983-29296-1-git-send-email-rnayak@ti.com>
References: <1371474983-29296-1-git-send-email-rnayak@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB20EA7@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 17, 2013 at 18:46:21, Nayak, Rajendra wrote:

> The powerdomain framework currently expects to always have a voltagedomain
> associated with a given powerdomain. We already have AM33xx which
> has no Voltage Controller/Voltage Processor as part of PRCM.
> There are more SoCs' to follow starting with AM437x and DRA7xx
> which do not have VC/VP. All these SoCs', hence do not support any
> form of auto-scaling of voltages, that was possible on earlier OMAPs'
> using the VFSM to trigger an i2c communication to the PMIC automatically
> on hitting a low power state.
> 
> Instead of adding dummy voltage domain data files, like was done for the
> AM33xx case, make the powerdomain framework aware of the fact that some
> SoCs' might not really have support for auto-scaling of voltages in hw.
> 
> Patches are based of 3.10-rc6 and are boot tested on am335x bone.

Tested-by: Afzal Mohammed <afzal@ti.com> (am335x evm)

Regards
Afzal
