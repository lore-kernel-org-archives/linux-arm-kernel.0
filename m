From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Fri, 28 Sep 2012 16:38:02 -0500
Subject: [PATCH 02/12] ata: mark probe function as __devinit rather than
 __init
In-Reply-To: <1348868177-21205-3-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-3-git-send-email-arnd@arndb.de>
Message-ID: <506618BA.4070509@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 04:36 PM, Arnd Bergmann wrote:
> Functions for hotplugging must be marked as __devinit so
> they do not get discarded, as pointed out by a build time
> warning from modpost.
> 
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> ---
>  drivers/ata/sata_highbank.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
> index 0d7c4c2..36a141a 100644
> --- a/drivers/ata/sata_highbank.c
> +++ b/drivers/ata/sata_highbank.c
> @@ -260,7 +260,7 @@ static const struct of_device_id ahci_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
>  
> -static int __init ahci_highbank_probe(struct platform_device *pdev)
> +static int __devinit ahci_highbank_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct ahci_host_priv *hpriv;

Thanks. I just ran into this today and couldn't figure out the error
message.

Acked-by: Mark Langsdorf <mark.langsdorf@calxeda.com>

--Mark Langsdorf
Calxeda, Inc.
