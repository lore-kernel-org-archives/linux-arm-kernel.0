From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Jun 2015 10:35:29 +0200
Subject: [RFC PATCH v6 2/2] nvmem: Add Vybrid OCOTP and OCROM support
In-Reply-To: <b4a52f6c229bdabbfe9d21c03cb04593dde33ec4.1435066190.git.maitysanchayan@gmail.com>
References: <cover.1435066190.git.maitysanchayan@gmail.com>
 <b4a52f6c229bdabbfe9d21c03cb04593dde33ec4.1435066190.git.maitysanchayan@gmail.com>
Message-ID: <20150624083529.GY2266@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

On Tue, Jun 23, 2015 at 07:14:57PM +0530, Sanchayan Maity wrote:
> +static struct nvmem_config ocotp_config = {
> +	.name = "soc_id",
> +};
> +
> +static struct nvmem_config rom_config = {
> +	.name = "rom_rev",
> +};

Srinivas, shouldn't we use the DT to setup these names, just like
clock-output-names does for example?

This is very likely to change from one board to another, and defining
a new compatible and/or driver for each board seems a bit fishy.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150624/ed090e33/attachment.sig>
