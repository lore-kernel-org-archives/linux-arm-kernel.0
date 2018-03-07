From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 7 Mar 2018 14:36:11 +0100
Subject: Bug#887873: linux-image-4.9.0-5-marvell: frequent "usercopy:
 kernel memory overwrite attempt detected" on QNAP NAS (ARM)
In-Reply-To: <1520395120.2285859.1294250416.5E5FC747@webmail.messagingengine.com>
References: <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180304174157.ajom7whbo7pr3qb4@jirafa.cyrius.com>
 <20180304204115.GD21710@lunn.ch>
 <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180305142846.GJ25189@lunn.ch>
 <1520265474.2408.8.camel@debian.org>
 <1520297697.4117371.1292731088.7BEDFAAE@webmail.messagingengine.com>
 <1520395120.2285859.1294250416.5E5FC747@webmail.messagingengine.com>
Message-ID: <20180307133611.GC18030@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What else can I try?

Do you have transparent huge pages enabled?

~$ cat /sys/kernel/mm/transparent_hugepage/enabled 
[always] madvise never

If so, could you disable it with:

echo never > /sys/kernel/mm/transparent_hugepage/enabled

and run your rsync command.

Thanks
	Andrew
