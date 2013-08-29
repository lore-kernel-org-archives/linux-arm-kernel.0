From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 17:12:17 +0100
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <521DD057.4040208@gmail.com>
References: <20130828113459.48ecbb34@armhf> <521DCD33.2070008@gmail.com>
 <20130828121943.1c8327ca@skate> <521DD057.4040208@gmail.com>
Message-ID: <20130829161217.GK10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 12:26:31PM +0200, Sebastian Hesselbarth wrote:

> Unfortunately, mvebu-audio has already been taken by Mark. Also, we
> know the differences for the three SoCs now and should have a compatible
> for each (and maybe mvebu-audio for fallback).

We're not at the merge window yet so we can always change it.  We can
also add additional compatible strings to the drivers at any point - the
device can list as many as it likes, this is useful if you've got new
controllers which are supersets of old ones for example.

> Also, we'll need to distinguish between the different audio controllers
> on a single SoC, i.e. i2s0 and i2s1. I suggest checking the (phys) reg
> base passed.

Why is this required - ideally this would have been mentioned in some of
the previous reviews...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/c7c8411d/attachment-0001.sig>
