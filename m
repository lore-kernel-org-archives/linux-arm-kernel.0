From: mlombard@redhat.com (Maurizio Lombardi)
Date: Wed, 7 Oct 2015 15:28:35 +0200
Subject: [PATCH] bnx2fc: reduce stack usage in __bnx2fc_enable
In-Reply-To: <5002023.QHmpbQ8s70@wuerfel>
References: <5002023.QHmpbQ8s70@wuerfel>
Message-ID: <56151E03.4050908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/07/2015 03:11 PM, Arnd Bergmann wrote:
> -	memset(&npiv_tbl, 0, sizeof(npiv_tbl));
> -	if (hba->cnic->get_fc_npiv_tbl(hba->cnic, &npiv_tbl))
> +	npiv_tbl = kzalloc(sizeof(struct cnic_fc_npiv_tbl), GFP_KERNEL);
> +	if (!npiv_tbl)
>  		goto done;
>  

If kzalloc() fails perhaps the function should return -ENOMEM, not zero.


Regards,
Maurizio Lombardi
