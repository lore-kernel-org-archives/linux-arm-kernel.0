From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 14 Jan 2013 09:45:24 +0100
Subject: $(make uImage) is stupid [Was: Re: Early kernel hang with big DTB
 appended]
In-Reply-To: <35730055.SShm3zF9mO@amdc1227>
References: <7811936.npteFbuYu2@amdc1227>
 <alpine.LFD.2.02.1301032144490.1263@xanadu.home>
 <35730055.SShm3zF9mO@amdc1227>
Message-ID: <20130114084524.GN14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

unrelated to the original problem ...

On Fri, Jan 04, 2013 at 11:18:56AM +0100, Tomasz Figa wrote:
> We are using uImages built with same parameters as those used in simple 
> 'make uImage', just with a DTB appended to zImage before running mkimage 
> on it.
note that the parameters used for $(make uImage) are not optimal, only
safe. They use (letting the MMU aside) the link address of the final
image as load address. That means as U-Boot probably didn't choose the
right address when reading the image it has to move it to the link
address and then jumps into it. Then the decompressor notices that the
compressed image is located where the decompressed image should go to
and so has to move the image again.

So you could save quite some time during boot if you'd teach U-Boot that
it can just use the image where it was loaded to.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
