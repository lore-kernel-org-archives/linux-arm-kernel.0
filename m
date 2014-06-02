From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Mon, 02 Jun 2014 22:24:41 +0200
Subject: [PATCH 3/3] arm: tegra: initial support for apalis t30
In-Reply-To: <538CA749.3010106@wwwdotorg.org>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <b470c9c8631a6ef021d140192eb07006de3cfd93.1401665237.git.marcel@ziswiler.com>
 <538CA749.3010106@wwwdotorg.org>
Message-ID: <538CDD89.6080605@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 06:33 PM, Stephen Warren wrote:
> I vaguely recall people speaking out against including "spidev" devices
> in DT because they don't represent actual HW, but rather a way to
> request that the SPI bus be exposed to user-space, which is a pure SW
> issue. Wouldn't it be better if the spidev interface worked like
> I2C_CHARDEV, where fake devices weren't actually required?

Well, there is one important difference. While I2C indeed does not have 
any further hardware dependency apart from the clock (SCL) and data 
(SDA) lines SPI actually requires dedicated hardware chip-select lines 
as well. But I guess NVIDIA has been rather ignorant about any of this 
in the past...
