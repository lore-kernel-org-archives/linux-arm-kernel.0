From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Jun 2012 11:42:33 +0100
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <69926c6ce4b1e004069662fb13287e9b.squirrel@www.codeaurora.org>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
 <20120601001617.GA16311@plastictigers.com>
 <74993ac9d11db0db7080c0864daef397.squirrel@www.codeaurora.org>
 <20120604102747.GC7538@opensource.wolfsonmicro.com>
 <69926c6ce4b1e004069662fb13287e9b.squirrel@www.codeaurora.org>
Message-ID: <20120604104233.GG7538@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 03:36:55AM -0700, Sagar Dharia wrote:

> I would expect that the slim_device's driver will only power-on the device
> during probe (and use wait_for_completion during 1st transfer to get LA).
> Typically transfers are not done as part of probe. Even if transfers need

I'd really expect that we'll have devices that we want to interact with
during probe, for example to determine the device variant.  I'd also
expect that it'd be useful to defer things like registering the device
with higher level APIs until we've actually got it up and running, it
tends to make life simpler.

> to be done as part of probe, I expect wait_for_completion (with timeout to
> avoid potential HW problems causing linux probe to wait forever) will be
> better than polling for get_logical_addr.

I agree that a completion is better if we have to block in the device
driver, but the idea someone suggested of having the framework generate
a second callback when it's assigned a logical address seems even
better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120604/44ac5acb/attachment.sig>
