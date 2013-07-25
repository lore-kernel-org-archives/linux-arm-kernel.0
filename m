From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 25 Jul 2013 15:30:40 +0530
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod: rt address space index for DT
In-Reply-To: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com>
References: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com>
Message-ID: <51F0F748.9020904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/5/2013 8:43 PM, Afzal Mohammed wrote:
> Address space is being removed from hwmod database and DT information
> in <reg> property is being used. Currently the 0th index of device
> address space is used to map for register target address. This is not
> always true, eg. cpgmac has it's sysconfig in second address space.
>
> Handle it by specifying index of device address space to be used for
> register target. As default value of this field would be zero with
> static initialization, existing behaviour of using first address space
> for register target while using DT would be kept as such.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
I have tested this patch and it's needed when we have CPSW Ethernet built-in to
go to low power state.

Tested-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
