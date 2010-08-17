From: error27@gmail.com (Dan Carpenter)
Date: Tue, 17 Aug 2010 20:32:05 +0200
Subject: [PATCH] ether1: Use net_device_stats from struct net_device
In-Reply-To: <1282061719-19645-1-git-send-email-tklauser@distanz.ch>
References: <1282061719-19645-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20100817183205.GH645@bicker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 06:15:19PM +0200, Tobias Klauser wrote:
> struct net_device has its own struct net_device_stats member, so use
> this one instead of a private copy in the ether1_priv struct.
> 

You missed one in ether1_open().

        memset (&priv(dev)->stats, 0, sizeof (struct net_device_stats));

regards,
dan carpenter
