From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 30 Nov 2010 14:01:43 +0200
Subject: [PATCH RESEND v3] ARM: s3c2442: Setup gpio {set,
	get}_pull callbacks
In-Reply-To: <4CF4E5C7.5020600@metafoo.de>
References: <000201cb8fae$4d61fd20$e825f760$%kim@samsung.com>
	<001801cb9056$65296530$2f7c2f90$%kim@samsung.com>
	<4CF4E5C7.5020600@metafoo.de>
Message-ID: <201011301401.44973.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 November 2010 13:53:43 Lars-Peter Clausen wrote:

> > Hmm...how about s3c_gpio_setpull_1updown(...)?
> > And actually, not used 3rd argument, "pull" now.
> > I prefer follwoing.
> 
> You need the 4th arguemnt, because the s3c2440 only supports pullups and
> the s3c2442 only supports pulldowns. So you want to return -EINVAL if
> somebody tries to set a pullup on a s3c2442 based board.
> Your proposed solution would return 0 and set a pulldown instead.

Well, at least it allows single-binary kernel for s3c24xx to exist. I think 
it's OK, as setting pull{up,down} bit for any non S3C_GPIO_PULL_NONE arg 
preserves semantics for all SoCs (s3c2410/s3c2440/s3c2442) by cost of not 
handling errors. Anyway, who wants to call cfgpull with S3C_GPIO_PULL_DOWN on 
s3c2410/s3c2440 or with S3C_GPIO_PULL_UP on s3c2442?
 
Regards
Vasily
