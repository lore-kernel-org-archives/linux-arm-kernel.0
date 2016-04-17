From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2016 16:09:30 +0200
Subject: [PATCH] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <201604111626.g2x2SCHX%fengguang.wu@intel.com>
References: <201604111626.g2x2SCHX%fengguang.wu@intel.com>
Message-ID: <5220051.FEUC6vJBCk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 April 2016 16:08:14 kbuild test robot wrote:
> 
>    230   * @offset: register offset
>    231   * @val: data to be written
>    232   **/
>    233  static void xudc_write64(void __iomem *addr, u32 offset, u64 val)
>    234  {
>    235  #if defined(CONFIG_PHYS_ADDR_T_64BIT)
>  > 236          writeq(val, addr + offset);
>    237  #endif
>    238  }
> 

I think you want lo_hi_writeq() rather than writeq().

	Arnd
