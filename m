From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 18:25:00 +0200
Subject: [PATCH 1/2] i2c-mv64xxx: Fix timing issue on Armada XP (errata
 FE-8471889)
In-Reply-To: <1370620140-17177-2-git-send-email-gregory.clement@free-electrons.com>
References: <1370620140-17177-1-git-send-email-gregory.clement@free-electrons.com>
 <1370620140-17177-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130607182500.10593e73@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri,  7 Jun 2013 17:48:59 +0200, Gregory CLEMENT wrote:

> +/*
> + * 5us delay in order to avoid repeated start
> + * timing violation on Armada XP SoC.
> + */
> +static int mv64xxx_i2c_errata_delay;

This should probably be a per-I2C controller variable, i.e in
mv64xxx_i2c_data.


> +	if (!mv64xxx_i2c_errata_delay &&
> +	    of_machine_is_compatible("marvell,armadaxp"))
> +		mv64xxx_i2c_errata_delay = 1;

I am wondering whether it should be done this way, or using a separate
DT property.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
