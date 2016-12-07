From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 7 Dec 2016 10:29:07 +0100
Subject: [PATCH 11/16] drivers/fsi: Add device read/write/peek functions
In-Reply-To: <1481076574-54711-4-git-send-email-christopher.lee.bostic@gmail.com>
References: <1481076574-54711-1-git-send-email-christopher.lee.bostic@gmail.com>
 <1481076574-54711-4-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <20161207092907.GC14742@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 08:09:33PM -0600, Chris Bostic wrote:
> diff --git a/include/linux/fsi.h b/include/linux/fsi.h
> index efa55ba..66bce48 100644
> --- a/include/linux/fsi.h
> +++ b/include/linux/fsi.h
> @@ -27,6 +27,12 @@ struct fsi_device {
>  	uint32_t		size;
>  };
>  
> +extern int fsi_device_read(struct fsi_device *dev, uint32_t addr,
> +		void *val, size_t size);
> +extern int fsi_device_write(struct fsi_device *dev, uint32_t addr,
> +		const void *val, size_t size);
> +extern int fsi_device_peek(struct fsi_device *dev, void *val);
> +
>  struct fsi_device_id {
>  	u8	engine_type;
>  	u8	version;
> @@ -40,7 +46,6 @@ struct fsi_device_id {
>  #define FSI_DEVICE_VERSIONED(t, v) \
>  	.engine_type = (t), .version = (v),
>  
> -
>  struct fsi_driver {
>  	struct device_driver		drv;
>  	const struct fsi_device_id	*id_table;

Strange whitespace change here :)

Not a real problem, I like the fact that you have broken this down into
very logical pieces making it much easier to review, thanks so much for
doing this.

greg k-h
