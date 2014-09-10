From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Sep 2014 12:24:57 +0100
Subject: ARM big endian cpu hotplug
In-Reply-To: <CAMQ1t3oDaYCQ+Uye3NDcHb8O4bvK=cauOfcqQvHqdieb8e8uEA@mail.gmail.com>
References: <CAMQ1t3oDaYCQ+Uye3NDcHb8O4bvK=cauOfcqQvHqdieb8e8uEA@mail.gmail.com>
Message-ID: <54103509.1020206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/14 12:07, Hemanth Kumar wrote:
> On ARM VE-A-15 ,When I enable CONFIG_MTD_CFI &
> CONFIG_MTD_CFI_LE_BYTE_SWAP and try to do cpu hotplug it throw's an
> error
> write error: Input/output error,If I enable
> CONFIG_MTD_CFI_BE_BYTE_SWAP and fix with below  code
> include/linux/mtd/map.h still it throw's write error: Input/output
> error when I do cpu hotplug this happening on
> v3.10,v3.12,v3.14,v3.15,v3.16,
>
> If I dont enable CONFIG_MTD_CFI & CONFIG_MTD_CFI_LE_BYTE_SWAP or
> CONFIG_MTD_CFI_BE_BYTE_SWAP cpu hot plug works fine.
>

Are you referring to ARM Vexpress platform with TC2/CA15_A7 card ?
If yes, idle doesn't work with CONFIG_MTD_CFI irrespective of
endianness, it's platform limitation.

Regards,
Sudeep
