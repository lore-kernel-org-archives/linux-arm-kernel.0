From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 25 Nov 2015 17:55:22 +0100
Subject: [PATCH net-next 3/3] net: mvneta: Add naive RSS support
In-Reply-To: <1448463243-21057-4-git-send-email-gregory.clement@free-electrons.com>
References: <1448463243-21057-1-git-send-email-gregory.clement@free-electrons.com>
 <1448463243-21057-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151125175522.0e8dd8b8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Wed, 25 Nov 2015 15:54:03 +0100, Gregory CLEMENT wrote:

>  	pp->rxq_def = rxq_def;
>  
> +	pp->indir[0] = rxq_def;

So now we have the RX queue in both pp->rxq_def and pp->indir[0] ? Is
this really useful ?

Also, if the RX queue becomes a per-port definition, why do you keep
the global rxq_def variable ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
