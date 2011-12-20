From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 17:57:10 -0800
Subject: [PATCH V2 2/4] i2c: tegra: Support DVC controller in device tree
In-Reply-To: <1324189772-26914-2-git-send-email-swarren@nvidia.com>
References: <1324189772-26914-1-git-send-email-swarren@nvidia.com>
 <1324189772-26914-2-git-send-email-swarren@nvidia.com>
Message-ID: <20111220015710.GB27789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 11:29:30PM -0700, Stephen Warren wrote:
> One of the Tegra I2C blocks is inside the DVC (Digital Voltage Controller)
> block. This block is identical to the rest of the I2C blocks, except that
> it only supports master mode, it has registers moved around, and it needs
> some extra init to get it into I2C mode.  The register moves are handled
> by i2c_readl and i2c_writel
> 
> This patch adds a new compatible value for controllers of this "DVC"
> type; I figured that this approach was reasonable, as opposed to adding
> an is-dvc property under the existing compatible value, since the HW
> truly is different.
> 
> v2: Call of_device_is_compatible() to determine is_dvc, instead of storing
> the flag in tegra_i2c_of_match[]'s .data field.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---

I've applied this one as well to the tegra for-3.3/drivers. Ben, let me know if
you want it through your tree but since it mostly fixes device tree usage
I figured it's OK for us to take.


-Olof
