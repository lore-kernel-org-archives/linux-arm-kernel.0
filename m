From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 10 Jul 2014 14:38:37 +0200
Subject: [PATCH 00/16] i2c: drop class based instantiaion for selected
 drivers
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20140710143837.558c1d07@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Wolfram Sang wrote:
> Some drivers were flagged to remove class based instantiation soon to improve
> boot-up time. Originally, I was planning for a longer deprecation time so users
> could switch over to some other kind of instantiation. However, the demand for
> the speed up is high enough and class based instantiation is used rarely, so
> the removal takes place now. To make up for the deprecation time, another
> warning is added to the i2c core pointing out that the behaviour has now
> changed:
> 
> +	/* Warn that the adapter lost class based instantiation */
> +	if (adapter->class == I2C_CLASS_DEPRECATED) {
> +		dev_dbg(&adapter->dev,
> +			"This adapter dropped support for I2C classes and "
> +			"won't auto-detect %s devices anymore. If you need it, check "
> +			"'Documentation/i2c/instantiating-devices' for alternatives.\n",
>
It's usually a bad idea to split kernel messages across source lines
because it makes searching for the corresponding source line for a
message found in the log difficult.
You could at least do the split at the sentence boundary.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
