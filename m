From: rafalo@cadence.com (Rafal Ozieblo)
Date: Thu, 26 Jan 2017 15:15:58 +0000
Subject: [PATCH net-next v2] macb: Common code to enable ptp support for
 MACB/GEM
In-Reply-To: <1484841375-11420-1-git-send-email-andrei.pistirica@microchip.com>
References: <1484841375-11420-1-git-send-email-andrei.pistirica@microchip.com>
Message-ID: <BN3PR07MB25160FCBCF19918C495F43B4C9770@BN3PR07MB2516.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andrei Pistirica [mailto:andrei.pistirica at microchip.com] 
> Sent: 19 stycznia 2017 16:56
> Subject: [PATCH net-next v2] macb: Common code to enable ptp support for MACB/GEM
> 
>  
> +static inline bool gem_has_ptp(struct macb *bp)
> +{
> +	return !!(bp->caps & MACB_CAPS_GEM_HAS_PTP);
> +}
Why don't you use hardware capabilities here? Would it be better to read it from hardware instead adding it to many configuration?
