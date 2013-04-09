From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 9 Apr 2013 11:37:39 +0200
Subject: [PATCH] i2c: s3c2410: Add SMBus emulation for block read
In-Reply-To: <1364308196-10101-1-git-send-email-prasanna.ps@samsung.com>
References: <1364308196-10101-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <20130409093739.GH3624@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 07:59:56PM +0530, Prasanna Kumar wrote:
> From: Jaemin Yoo <jmin.yoo@samsung.com>
> 
> SMBus read and write are supported by the emulation layer of i2c
> framework if the controller doesn't have SMBus features.
> 
> I2C_M_RECV_LEN flag is used to let i2c drivers know rx length is not
> yet determined but will be read to the first byte in rx buffer.
> 
> s3c2410 doesn't handle this flag. So only one byte is read from slave.
> There fore following two features are added to the driver code.
> 
> 1. skip rx length check if I2C_M_RECV_LEN is set and the length is 1.
> 2. add actual bytes to the rx length after reading first bytes if
>    I2C_M_RECV_LEN.
> 
> I2C_M_RECV_LEN is only set for SMBus command. So this code does not
> affect legacy codes which only use i2c command for s3c2410.
> 
> Signed-off-by: Jaemin Yoo <jmin.yoo@samsung.com>
> Tested-by: Prasanna Kumar <prasanna.ps@samsung.com>

Applied to for-next, thanks!
