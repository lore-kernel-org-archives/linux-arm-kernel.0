From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 26 Jun 2018 19:39:43 +0530
Subject: [PATCH v2 10/10] i2c: remove i2c_lock_adapter and use
 i2c_lock_bus directly
In-Reply-To: <20180620051803.12206-11-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-11-peda@axentia.se>
Message-ID: <4e0545e3-fee9-cf29-bae1-e442347e3cb8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 June 2018 10:48 AM, Peter Rosin wrote:
> The i2c_lock_adapter name is ambiguous since it is unclear if it
> refers to the root adapter or the adapter you name in the argument.
> The natural interpretation is the adapter you name in the argument,
> but there are historical reasons for that not being the case; it
> in fact locks the root adapter. Just remove the function and force
> users to spell out the I2C_LOCK_ROOT_ADAPTER name to indicate what
> is really going on. Also remove i2c_unlock_adapter, of course.
> 
> This patch was generated with
> 
> git grep -l 'i2c_\(un\)\?lock_adapter' \
> | xargs sed -i 's/i2c_\(un\)\?lock_adapter(\([^)]*\))/'\
> 'i2c_\1lock_bus(\2, I2C_LOCK_ROOT_ADAPTER)/g'
> 
> followed by white-space touch-up.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/busses/i2c-brcmstb.c   |  8 ++++----
>  drivers/i2c/busses/i2c-davinci.c   |  4 ++--

On DM644x and DA850 EVMs applying this series does not seem to break I2C
functionality. So:

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
