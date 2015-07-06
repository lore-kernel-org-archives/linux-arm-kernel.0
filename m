From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 06 Jul 2015 12:26:40 +0200
Subject: [PATCH] thermal: consistently use int for temperatures
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150706122640.2a61ca05@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> The thermal code uses int, long and unsigned long for temperatures
> in different places.
> 
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0?C. This will
> probably immediately shut the machine down due to overtemperature if
> started below 0?C.
> 
> 'long' is 64bit on several architectures. This is not needed since
> INT_MAX ?mC is above the melting point of all known materials.
> 
> Consistently use a plain 'int' for temperatures throughout the
> thermal code and the drivers. This only changes the places in the
> drivers where the temperature is passed around as pointer, when
> drivers internally use another type this is not changed.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha, thanks for this cleanup work. 

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
