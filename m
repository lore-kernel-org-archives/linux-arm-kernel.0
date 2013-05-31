From: csd@broadcom.com (Christian Daudt)
Date: Fri, 31 May 2013 08:41:40 -0700
Subject: [PATCH V4 1/3] mmc: sdhci: Add size for caller in
 init+register
In-Reply-To: <1369860607-25572-1-git-send-email-csd@broadcom.com>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
Message-ID: <51A8C4B4.6020104@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
  Can you pls take this patch and the one named "[PATCH V4 2/3] ARM: 
mmc: bcm281xx SDHCI driver" into your tree ?

  Thanks,
     csd.

On 13-05-29 01:50 PM, Christian Daudt wrote:
> Add a param to allow users of sdhci_pltfm to allocate private space
> in calls to sdhci_pltfm_init+sdhci_pltfm_register. This is implemented
> in the same way as sdhci does for its users.
>   None of the users have been migrated yet and are passing in zero to
> retain their private allocation.
>
> - todo: migrate clients to using allocation this way
> - todo: remove priv variable once migration is complete
>
> Also removed unused variable in sdhci_pltfm_init fn
>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
