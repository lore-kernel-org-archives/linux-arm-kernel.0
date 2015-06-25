From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 25 Jun 2015 09:23:18 +0200
Subject: [PATCH 11/12] [media] tsin: c8sectpfe: Add Kconfig and Makefile
 for the driver.
In-Reply-To: <1435158670-7195-12-git-send-email-peter.griffin@linaro.org>
References: <1435158670-7195-1-git-send-email-peter.griffin@linaro.org>
 <1435158670-7195-12-git-send-email-peter.griffin@linaro.org>
Message-ID: <1435216998.4528.100.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-06-24 at 16:11 +0100, Peter Griffin wrote:
> --- /dev/null
> +++ b/drivers/media/tsin/c8sectpfe/Makefile

> +c8sectpfe-y += c8sectpfe-core.o c8sectpfe-common.o c8sectpfe-dvb.o
> +
> +obj-$(CONFIG_DVB_C8SECTPFE) += c8sectpfe.o
> +
> +ifneq ($(CONFIG_DVB_C8SECTPFE),)
> +	c8sectpfe-y += c8sectpfe-debugfs.o
> +endif

Isn't the above equivalent to
    c8sectpfe-y += c8sectpfe-core.o c8sectpfe-common.o c8sectpfe-dvb.o c8sectpfe-debugfs.o

    obj-$(CONFIG_DVB_C8SECTPFE) += c8sectpfe.o

Or am I missing something subtle here?


Paul Bolle
