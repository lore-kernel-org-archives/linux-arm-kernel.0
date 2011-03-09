From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Mar 2011 21:02:36 +0100
Subject: [RFC PATCHv1 2/2] ux500: Export U8500 SoC info through sysfs
In-Reply-To: <1299689961-5028-3-git-send-email-maxime.coquelin-nonst@stericsson.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-3-git-send-email-maxime.coquelin-nonst@stericsson.com>
Message-ID: <201103092102.36712.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 March 2011 17:59:21 Maxime Coquelin wrote:
> ST-Ericsson's U8500 implementation.
> Register sysfs SoC interface, and export SoC ID, process and silicon revision
> number.

> +static char *ux500_get_soc_id(struct sys_soc_info *si)
> +{
> +	void __iomem *uid_base = __io_address(U8500_BB_UID_BASE);

> +static char *ux500_get_revision(struct sys_soc_info *si)
> +{
> +	unsigned int rev = dbx500_revision();
>
> +
> +static char *ux500_get_process(struct sys_soc_info *si)
> +{

These should all just be attributes of the platform device that
represents your SoC.

	Arnd
