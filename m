From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Feb 2013 14:33:35 +0000
Subject: [PATCH 24/35] mfd: ab8500: Remove unnecessary 'struct device'
 declaration
In-Reply-To: <1360933026-30325-25-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-25-git-send-email-lee.jones@linaro.org>
Message-ID: <201302251433.36121.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Lee Jones wrote:
> A recent patch saw the device.h include being removed from some other
> include files and replaced with a 'struct device' declaration instead.
> However, neither the include nor the declaration is actually required.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/abx500.h |    2 --
>  1 file changed, 2 deletions(-)

In my copy of the file, we the declaration


int ab8500_bm_of_probe(struct device *dev,
                       struct device_node *np,
                       struct abx500_bm_data *bm);



and others that use 'struct device'. C99 requires that a struct is declared
in advance  before you use it in a function declaration.

	Arnd
