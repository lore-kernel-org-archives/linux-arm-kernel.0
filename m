From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 07 Jun 2014 11:46:22 +0100
Subject: [PATCH 2/5] staging/iio: IIO_SIMPLE_DUMMY_BUFFER neds IIO_BUFFER
In-Reply-To: <1402001295-1980118-3-git-send-email-arnd@arndb.de>
References: <1402001295-1980118-1-git-send-email-arnd@arndb.de>
 <1402001295-1980118-3-git-send-email-arnd@arndb.de>
Message-ID: <5392ED7E.7060201@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/14 21:48, Arnd Bergmann wrote:
> An obviously missing 'select' statement, without this we
> get a link error
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio at vger.kernel.org
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> ---
>   drivers/staging/iio/Kconfig | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index b36feb0..fa38be0 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -36,10 +36,11 @@ config IIO_SIMPLE_DUMMY_EVENTS
>            Add some dummy events to the simple dummy driver.
>
>   config IIO_SIMPLE_DUMMY_BUFFER
> -       boolean "Buffered capture support"
> -       select IIO_KFIFO_BUF
> -       help
> -         Add buffered data capture to the simple dummy driver.
> +	boolean "Buffered capture support"
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
> +	help
> +	  Add buffered data capture to the simple dummy driver.
>
>   endif # IIO_SIMPLE_DUMMY
>
>
