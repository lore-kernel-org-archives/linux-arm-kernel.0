From: joe@perches.com (Joe Perches)
Date: Tue, 13 Dec 2011 13:40:31 -0800
Subject: [PATCH v3 resend2] s3c/s3c24xx: arm: leds: Make s3c24xx LEDS
 driver use gpiolib
In-Reply-To: <4EE7C4AD.8090805@solonet.org.ua>
References: <4EE7B41C.5080006@solonet.org.ua>
 <1323810417.3837.25.camel@joe2Laptop> <4EE7C1C9.8080000@solonet.org.ua>
 <1323811732.3837.27.camel@joe2Laptop> <4EE7C4AD.8090805@solonet.org.ua>
Message-ID: <1323812431.3837.31.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-13 at 23:33 +0200, Denis Kuzmenko wrote:
> On 12/13/2011 11:28 PM, Joe Perches wrote:
> > The LEDF_ACTLOW use is dependent on it being #defined
> > to 1 when using ^.  I think that's unintelligible.
> Sorry, can't understand. Can you please clarify last two sentences?

	s3c2410_gpio_setpin(pd->gpio, (value ? 1 : 0) ^
			    (pd->flags & S3C24XX_LEDF_ACTLOW));

I think this should be:
	s3c2410_gpio_setpin(pd->gpio,
			    !!value ^ !!(pd->flags & S3C24XX_LEDF_ACTLOW));
