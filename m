From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 12 Jan 2017 20:22:09 +0100
Subject: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
In-Reply-To: <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
 <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
Message-ID: <20170112192209.qih7zm4x6k3rzt4i@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Because the adapter registration i2c_add_adapter() can fail, information
> about the adapter initialization would be expected only in case of
> successful registration.

Exactly.

> 
> The information sent to the kernel log buffer here is quite trivial,
> probably dev_info() can be just removed, but in any case it should be
> a separate change.

I am not sure I get you here, but to not have false positive success
messages, I'd think that should be all in one patch.

Regards,

   Wolfram
