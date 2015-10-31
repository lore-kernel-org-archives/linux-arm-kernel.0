From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 31 Oct 2015 10:18:41 +0000
Subject: [PATCH 4/5] i2c: add i2c_check_quirks helper function
In-Reply-To: <1446118467-26453-4-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-4-git-send-email-nicola@corna.info>
Message-ID: <56349581.8070900@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/15 11:34, Nicola Corna wrote:
> This patch adds a i2c_check_quirks helper function to check the quirk flags
> of an i2c adapter, in a similar way to i2c_check_functionality.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>
I don't know about everyone else, but I'm finding this particular style
of email thread very difficult to follow.
Perhaps either:
* Start a new thread for each new series version.
* label the whole series with a rolling version number rather than doing it
  on a per patch basis.

Would just make it easier to keep track when one reads the thread a while
after it started!

Jonathan
> ---
>  include/linux/i2c.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 9697002..51028f3 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -617,6 +617,20 @@ static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
>  	return (func & i2c_get_functionality(adap)) == func;
>  }
>  
> +/**
> + * i2c_check_quirks() - Function for checking the quirk flags in an i2c adapter
> + * @adap: i2c adapter
> + * @quirks: quirk flags
> + *
> + * Return: true if the adapter has all the specified quirk flags, false if not
> + */
> +static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
> +{
> +	if (!adap->quirks)
> +		return false;
> +	return (adap->quirks->flags & quirks) == quirks;
> +}
> +
>  /* Return the adapter number for a specific adapter */
>  static inline int i2c_adapter_id(struct i2c_adapter *adap)
>  {
> 
