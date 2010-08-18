From: shemminger@vyatta.com (Stephen Hemminger)
Date: Wed, 18 Aug 2010 08:33:04 -0700
Subject: [PATCH v2] ether1: Use net_device_stats from struct net_device
In-Reply-To: <1282115064-3701-1-git-send-email-tklauser@distanz.ch>
References: <1282061719-19645-1-git-send-email-tklauser@distanz.ch>
	<1282115064-3701-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20100818083304.2ef2eea4@nehalam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Aug 2010 09:04:24 +0200
Tobias Klauser <tklauser@distanz.ch> wrote:

>  
> -	memset (&priv(dev)->stats, 0, sizeof (struct net_device_stats));
> +	memset(&dev->stats, 0, sizeof(struct net_device_stats));

This is incorrect, just remove the memset.  The stats are initialized
when device is created.  The Linux device driver convention is to
keep stats when device is set down and brought back up; that is what
the majority of other drivers do.

-- 
