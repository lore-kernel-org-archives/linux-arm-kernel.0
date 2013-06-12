From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Jun 2013 12:42:40 +0200
Subject: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
In-Reply-To: <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130612104207.GE30841@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 06:41:24PM +0200, Thomas Petazzoni wrote:
[...]
> @@ -292,6 +454,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
>  
>  #endif
>  
> +	armada_370_xp_msi_init(node);
> +

So I see that you don't have access to the original platform device
here, but you could use of_find_device_by_node() to obtain it and pass
that into armada_370_xp_msi_init() in order to set the msi_chip.dev
field. Or you could do the lookup in armada_370_xp_msi_init() if you
don't need it for anything else in armada_370_xp_mpic_of_init().

Doing the above will also allow you to use devm_kzalloc() as Grant
suggested in his reply.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/6af6e30d/attachment.sig>
