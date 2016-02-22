From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 22 Feb 2016 11:00:02 +0000
Subject: [PATCH 2/2] net, thunderx: Use bool in structs where possible
In-Reply-To: <1455799149-19590-3-git-send-email-rrichter@caviumnetworks.com>
References: <1455799149-19590-1-git-send-email-rrichter@caviumnetworks.com>
 <1455799149-19590-3-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CCE6A71@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter
> Sent: 18 February 2016 12:39
> From: Robert Richter <rrichter@cavium.com>
> 
> Looks like the :1 notation was accidentally introduced (this still
> uses 1 byte per flag). Using bool instead, which is the common use.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/net/ethernet/cavium/thunder/nic.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> index 688828865c48..fa5b1d2d8e23 100644
> --- a/drivers/net/ethernet/cavium/thunder/nic.h
> +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> @@ -262,9 +262,9 @@ struct nicvf {
>  	struct pci_dev		*pdev;
>  	u8			vf_id;
>  	u8			node;
> -	u8			tns_mode:1;
> -	u8			sqs_mode:1;
> -	u8			loopback_supported:1;
> +	bool			tns_mode;
> +	bool                    sqs_mode;
> +	bool			loopback_supported;
>  	bool			hw_tso;
>  	u16			mtu;
>  	struct queue_set	*qs;

If the size of the structure matters, you've just made it two bytes larger.
(Although it looks like there is some padding).

	David
