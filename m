From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 5 Dec 2011 16:25:31 +0000
Subject: [PATCH v3 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1322579473-8804-4-git-send-email-pawel.moll@arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-4-git-send-email-pawel.moll@arm.com>
Message-ID: <20111205162520.GA27547@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 03:11:11PM +0000, Pawel Moll wrote:
> This patch provides hooks for DT-based tile machine implementations
> and adds Device Tree description for the motherboard.

[...]

> +static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
> +			&v2m_flash_data),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
> +	{}

Are we missing some AUXDATA here?  I thought we had a lot more drivers
which are not converted to OF, such as ambakmi and many more.

I notice some things explicitly failing, e.g.:

clcd-pl11x: probe of 10020000.clcd failed with error -22
clcd-pl11x: probe of 1001f000.clcd failed with error -22

...I haven't tracked down exactly what is going on here, yet.

Cheers
---Dave
