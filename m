From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 28 Apr 2018 14:31:36 +0200
Subject: [PATCH v3 0/6] Add different features for I2C
In-Reply-To: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180428123136.hxcg4njtbrykuisi@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 03:24:52PM +0200, Pierre-Yves MORDRET wrote:
> Append new I2C STM32F7 feature set. This includes 10 bit support, slave
> support, SMBBus protocols support, DMA Support and eventually an I2C release
> mechanism.

Applied to for-next, thanks!

While building, I saw this. While this is mostly not related to your
patch series, maybe you want to have a look at it?

drivers/i2c/busses/i2c-stm32f7.c:227: warning: Function parameter or member 'node' not described in 'stm32f7_i2c_timings'
drivers/i2c/busses/i2c-stm32f7.c:227: warning: Function parameter or member 'presc' not described in 'stm32f7_i2c_timings'
drivers/i2c/busses/i2c-stm32f7.c:227: warning: Function parameter or member 'scll' not described in 'stm32f7_i2c_timings'
drivers/i2c/busses/i2c-stm32f7.c:255: warning: Function parameter or member 'smbus_buf' not described in 'stm32f7_i2c_msg'
drivers/i2c/busses/i2c-stm32f7.c:307: warning: cannot understand function prototype: 'struct stm32f7_i2c_spec i2c_specs[] = '

And don't forget to add yourself as MAINTAINER as I mentioned in the old
thread.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180428/aa462116/attachment.sig>
