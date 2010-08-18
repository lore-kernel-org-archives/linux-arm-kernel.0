From: davem@davemloft.net (David Miller)
Date: Wed, 18 Aug 2010 13:10:43 -0700 (PDT)
Subject: [PATCH v2] ether1: Use net_device_stats from struct net_device
In-Reply-To: <20100818083304.2ef2eea4@nehalam>
References: <1282061719-19645-1-git-send-email-tklauser@distanz.ch>
	<1282115064-3701-1-git-send-email-tklauser@distanz.ch>
	<20100818083304.2ef2eea4@nehalam>
Message-ID: <20100818.131043.226780154.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Wed, 18 Aug 2010 08:33:04 -0700

> On Wed, 18 Aug 2010 09:04:24 +0200
> Tobias Klauser <tklauser@distanz.ch> wrote:
> 
>>  
>> -	memset (&priv(dev)->stats, 0, sizeof (struct net_device_stats));
>> +	memset(&dev->stats, 0, sizeof(struct net_device_stats));
> 
> This is incorrect, just remove the memset.  The stats are initialized
> when device is created.  The Linux device driver convention is to
> keep stats when device is set down and brought back up; that is what
> the majority of other drivers do.

Yep, both the ether1 and ether3 patch have this problem.  Looks
like we'll see v4 coming some :-)
