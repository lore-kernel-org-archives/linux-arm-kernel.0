From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Thu, 21 Apr 2011 19:02:26 +0400
Subject: [PATCH] pxa/hx4700: use gpio arrays for global gpio initialization
In-Reply-To: <1303329317.21545.5.camel@flow>
References: <1303329317.21545.5.camel@flow>
Message-ID: <20110421150226.GA10052@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:55 Wed 20 Apr     , Philipp Zabel wrote:
> gpio_request_arrays() is a functional replacement for hx4700_gpio_request(),
> which is now obsolete.

[snip]

> -	hx4700_gpio_request(ARRAY_AND_SIZE(global_gpios));
> +	gpio_request_array(ARRAY_AND_SIZE(global_gpios));

It would be nice to check return value here and print some message on error,
as unlike hx4700_gpio_request, gpio_request_array() is completely silent.

-- 
Best regards,
Dmitry "MAD" ArtAMonow
