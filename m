From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 09:25:34 +0200
Subject: [PATCH v5 2/2] mmc: host: s3cmci: allow probing from device tree
In-Reply-To: <1489799633-29278-3-git-send-email-sergio.prado@e-labworks.com>
References: <1489799633-29278-1-git-send-email-sergio.prado@e-labworks.com>
 <1489799633-29278-3-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <CAK8P3a2emCf=KtpCJMOaJnr89Gi+rCi0eun_vjb1wiYB=JR6jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 2:13 AM, Sergio Prado
<sergio.prado@e-labworks.com> wrote:

>
> +static const struct of_device_id s3cmci_dt_match[] = {
> +       {
> +               .compatible = "samsung,s3c2410-sdi",
> +               .data = (void *)0,
> +       },
> +       {
> +               .compatible = "samsung,s3c2412-sdi",
> +               .data = (void *)1,
> +       },
> +       {
> +               .compatible = "samsung,s3c2440-sdi",
> +               .data = (void *)1,
> +       },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
> +

The names don't match:

In file included from /git/arm-soc/drivers/mmc/host/s3cmci.c:14:0:
/git/arm-soc/drivers/mmc/host/s3cmci.c:1844:25: error:
'sdhci_s3c_dt_match' undeclared here (not in a function); did you mean
's3cmci_dt_match'?
 MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
                         ^
/git/arm-soc/include/linux/module.h:212:21: note: in definition of
macro 'MODULE_DEVICE_TABLE'
 extern const typeof(name) __mod_##type##__##name##_device_table  \
                     ^~~~
/git/arm-soc/include/linux/module.h:212:27: error:
'__mod_of__sdhci_s3c_dt_match_device_table' aliased to undefined
symbol 'sdhci_s3c_dt_match'
 extern const typeof(name) __mod_##type##__##name##_device_table  \
                           ^
/git/arm-soc/drivers/mmc/host/s3cmci.c:1844:1: note: in expansion of
macro 'MODULE_DEVICE_TABLE'
 MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
 ^~~~~~~~~~~~~~~~~~~
/git/arm-soc/scripts/Makefile.build:314: recipe for target
'drivers/mmc/host/s3cmci.o' failed

Can you send a fix?

       Arnd
