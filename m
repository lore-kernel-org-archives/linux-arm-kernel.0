From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 16 Jan 2015 17:15:48 +0100
Subject: [PATCHv2 3/3] ARM: mvebu: use arm_coherent_dma_ops and re-enable
 hardware I/O coherency
In-Reply-To: <1421424689-5971-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1421424689-5971-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150116161548.GD17658@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

In patch 1/3 you add a comment here saying why you have turned it off.
This hunk turns it back on again. But i don't see the comment being
removed?

Thanks
	Andrew

> @@ -253,7 +206,7 @@ static int coherency_type(void)
>   */
>  int coherency_available(void)
>  {
> -	return false;
> +	return coherency_type() != COHERENCY_FABRIC_TYPE_NONE;
>  }
>  
>  int __init coherency_init(void)
> -- 
> 2.1.0
> 
