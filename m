From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 10:59:28 +0200
Subject: [PATCH v10 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1431991481-25684-5-git-send-email-lho@apm.com>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-4-git-send-email-lho@apm.com>
 <1431991481-25684-5-git-send-email-lho@apm.com>
Message-ID: <2097631.G0OFDqxtEt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 May 2015 17:24:40 Loc Ho wrote:
> +       tmp_ctx.mcu_id = ((res.start >> 16) & 0xF) / 4;
> 

Just found this line: you are effectively hardcoding the physical
register layout of the chip in the driver here, to get the index
of the memory controller. This is a very bad idea as it prevents
you from reusing this driver for another chip that puts the
same registers in a different place, don't do that.

	Arnd
