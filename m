From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 22 Sep 2011 23:47:37 +0100
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <4E7BA661.7070903@cavium.com>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110922212909.49966cf4@lxorguk.ukuu.org.uk>
	<4E7BA661.7070903@cavium.com>
Message-ID: <20110922234737.05dff9f8@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> How would a given driver know that something else is waiting for it?  Or 
> would we add the explicit kick to each and every driver in the tree?

I think there are very very few drivers that have this property and don't
already implicitly cause a probe by creating a new bus or device.

Those drivers that set something up for another device really should
know what is going on because they are making a guarantee that they are
ready for the other device to call into them or whatever is going on at
some point, either explicitly in the kick or implicitly in returning from
their probe method.

I know which I think is clearer and easier for a 3rd party to see and not
miss completely when updating code.

Alan
