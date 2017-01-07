From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 7 Jan 2017 15:05:31 +0000
Subject: [PATCH 0/3] crypto: picoxcell - Cleanups removing non-DT code
In-Reply-To: <1483376819-26726-1-git-send-email-javier@osg.samsung.com>
References: <1483376819-26726-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20170107150531.gx5xmbbnombtvvju@maple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Mon, Jan 02, 2017 at 02:06:56PM -0300, Javier Martinez Canillas wrote:
> Hello,
> 
> This small series contains a couple of cleanups that removes some driver's code
> that isn't needed due the driver being for a DT-only platform.
> 
> The changes were suggested by Arnd Bergmann as a response to a previous patch:
> https://lkml.org/lkml/2017/1/2/342
> 
> Patch #1 allows the driver to be built when the COMPILE_TEST option is enabled.
> Patch #2 removes the platform ID table since isn't needed for DT-only drivers.
> Patch #3 removes a wrapper function that's also not needed if driver is DT-only.
> 
> Best regards,
> 
> 
> Javier Martinez Canillas (3):
>   crypto: picoxcell - Allow driver to build COMPILE_TEST is enabled
>   crypto: picoxcell - Remove platform device ID table
>   crypto: picoxcell - Remove spacc_is_compatible() wrapper function
> 
>  drivers/crypto/Kconfig            |  2 +-
>  drivers/crypto/picoxcell_crypto.c | 28 +++-------------------------
>  2 files changed, 4 insertions(+), 26 deletions(-)

Acked-by: Jamie Iles <jamie@jamieiles.com>

Thanks,

Jamie
