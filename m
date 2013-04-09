From: dianders@chromium.org (Doug Anderson)
Date: Tue, 9 Apr 2013 16:30:09 -0700
Subject: [PATCH v4] mmc: dw_mmc: let device core setup the default pin
 configuration
In-Reply-To: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
References: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAD=FV=VJ-ykDNqYKQ=fqxeOD6bRNLW02VT4bjsRHRAuXLcCpQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Mon, Apr 8, 2013 at 10:59 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> @@ -2002,7 +1994,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>                 if (ret) {
>                         dev_err(host->dev,
>                                 "failed to enable regulator: %d\n", ret);
> -                       goto err_setup_bus;
> +                       return ret;

It seems like you'd need a "mmc_free_host(mmc);" in this case don't
you?  AKA: this should be a goto and not a return.

-Doug
