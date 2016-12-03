From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Dec 2016 21:15:10 +0100
Subject: [PATCH v5] PM/devfreq: add suspend frequency support
In-Reply-To: <1478599598-26015-1-git-send-email-hl@rock-chips.com>
References: <1478599598-26015-1-git-send-email-hl@rock-chips.com>
Message-ID: <20161203201509.GB13417@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 98c6993..8567153 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -172,6 +172,7 @@ struct devfreq {
>  	struct delayed_work work;
>  
>  	unsigned long previous_freq;
> +	unsigned long suspend_freq;
>  	struct devfreq_dev_status last_status;
>  
>  	void *data; /* private data for governors */
> @@ -179,6 +180,7 @@ struct devfreq {
>  	unsigned long min_freq;
>  	unsigned long max_freq;
>  	bool stop_polling;
> +	bool suspend_flag;
>  
>  	/* information for device frequency transition */
>  	unsigned int total_trans;

It would be nice to comment what "suspend_flag" is... plus... Would it
be possible to rename suspend_freq or suspend_flag? They are really
really similar visually...

Thanks.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161203/6d21481d/attachment.sig>
