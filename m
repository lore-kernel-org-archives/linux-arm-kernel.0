From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 30 Jul 2015 11:40:25 +0200
Subject: [PATCH 16/20] power/reset: at91-reset: remove useless
 at91_reset_platform_probe()
In-Reply-To: <1438215726-27452-17-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438215726-27452-17-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150730114025.3eed9c1d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

On Thu, 30 Jul 2015 02:22:02 +0200, Alexandre Belloni wrote:

>  static int at91_reset_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  
> -	if (pdev->dev.of_node)
> -		ret = at91_reset_of_probe(pdev);
> -	else
> -		ret = at91_reset_platform_probe(pdev);
>  
> +	ret = at91_reset_of_probe(pdev);

Maybe it no longer makes sense to have separate at91_reset_probe() and
at91_reset_of_probe() functions then.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
