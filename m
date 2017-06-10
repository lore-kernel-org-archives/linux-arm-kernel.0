From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 10 Jun 2017 22:32:08 +0800
Subject: [PATCH 0/2] Add I2C driver for ZTE ZX2967 family SoCs
In-Reply-To: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20170610143207.GA9839@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Sun, May 28, 2017 at 12:59:34PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> Hi Wolfram,
> 
> The ZX2967 I2C driver submission had gone through quite a number of
> review iterations [1], and seems close to be accepted.  But for some
> reason, the ball got dropped from there.  I'm here to pick it up and
> hopefully move it forward.
> 
> This is basically a resend of the latest posting from Baoyou with
> Wolfram's comments on v7 fully addressed.
> 
> Changes since v7:
>  - Rebase and test on v4.12-rc2.
>  - Drop the dev_err() and hardware reset on timeout, which is not really
>    necessary.
>  - Return -ETIMEDOUT instead of -EIO on timeout.
>  - Unify zx2967_i2c_xfer_write_bytes() and zx2967_i2c_xfer_read_bytes()
>    into one function zx2967_i2c_xfer_bytes(), and zx2967_i2c_xfer_write()
>    and zx2967_i2c_xfer_read() into zx2967_i2c_xfer_msg().

Any comments on the series?  We hope it can get into v4.13 merge window.

Shawn
