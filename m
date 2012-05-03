From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 May 2012 10:50:26 +0200
Subject: [PATCH] gpio: Add simple poweroff-gpio driver
In-Reply-To: <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
References: <20120501195603.GW25584@lunn.ch>
 <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20120503085026.GE13023@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	if (gpio_request(gpio_num, "poweroff-gpio")) {
> +		pr_err("%s: Could not get GPIO %d", __func__, gpio_num);
> +		return -ENODEV;
> +	}
> +	if (gpio_direction_output(gpio_num, gpio_active_low)) {
> +		pr_err("%s: Could not set direction of GPIO %d",
> +		       __func__, gpio_num);
> +		return -ENODEV;
> +	}

On error, you are missing a gpio_free().

   Andrew
