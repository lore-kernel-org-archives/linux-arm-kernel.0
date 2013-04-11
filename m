From: michal.bachraty@streamunlimited.com (Michal Bachraty)
Date: Thu, 11 Apr 2013 09:44:47 +0200
Subject: [PATCH v7] clk: add si5351 i2c common clock driver
In-Reply-To: <5165A0FD.5030308@gmail.com>
References: <1365439617-18816-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <14854575.YAd2OMKOy9@ganymedes> <5165A0FD.5030308@gmail.com>
Message-ID: <11205025.2MA5VbIUoF@ganymedes>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wednesday, April 10, 2013 19:27:25 Sebastian Hesselbarth wrote:
> Hmm, is there any driver using the clock output? Does it
> clk_prepare_enable() the clock? I tend not to mess with anything the
> bootloader or eeprom config left disabled. It works for me, but here the
> driver will prepare/enable the clock prior use.

For my case, disabled clock outputs in bootloader are correct. I'm working on 
module board with lot of purposes. For one I need to tune frequncy, for other 
not. In some cases I can use  clk_prepare_enable. For now, I need to tune clk, 
so I can't use clk_prepare_enable. Si5351 chip has no problem with enabling 
clock output multiple times, when calling clk_set_rate. So if this feature 
will not be in driver, I need to stay with patch upon driver.

Many thaks for writting driver,

Michal
