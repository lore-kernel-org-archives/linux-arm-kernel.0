From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 14 Oct 2013 10:04:58 +0200
Subject: [PATCH 01/11] usb: chipidea: Add power management support
In-Reply-To: <1381570513-24927-2-git-send-email-peter.chen@freescale.com>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
 <1381570513-24927-2-git-send-email-peter.chen@freescale.com>
Message-ID: <20131014100458.4f577d01@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Peter Chen wrote:
> This commit adds runtime and system power management support for
> chipidea core. The runtime pm support is controlled by glue
> layer, it can be enabled by flag CI_HDRC_SUPPORTS_RUNTIME_PM.
> 
[...]
> +#ifdef CONFIG_PM
> +static int ci_controller_suspend(struct device *dev)
> +{
> +	struct ci_hdrc *ci = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "at %s\n", __func__);
> +
> +	if (atomic_read(&ci->in_lpm))
> +		return 0;
> +
What does this 'atomic_read()' buy you over just testing/assinging a
simple integer. Note that just because the function has 'atomic' in
its name the sequence:
	atomic_read();
...
	atomic_set();
does not magically become an atomic operation.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
