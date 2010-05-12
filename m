From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 13 May 2010 08:13:59 +1000
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <20100512150057.GA29867@atrey.karlin.mff.cuni.cz>
References: <1273569821.21352.19.camel@pasglop>
	<1273575478.21352.29.camel@pasglop>
	<20100512150057.GA29867@atrey.karlin.mff.cuni.cz>
Message-ID: <1273702439.21352.128.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>   Could you get the filesystem image with: e2image -r /dev/sdb2 buggy-image
> bzip2 it and make it available somewhere? Maybe I could guess something
> from the way the filesystem gets corrupted.
>   Oh, and also overwrite the partition with zeros before calling mkfs to make
> the analysis simpler.

Will do asap.

> > In fact, if I do ls /mnt/test/usr/bin/ I see debconf but if I do
> > ls /mnt/test/usr/bin/chrt then I get No such file or directory.
> > 
> > So something is badly wrong :-)
> > 
> > Now, trying without the dir_index feature (mkfs.ext3 -O ^dir_index)
> > and it works fine. All my md5sum's are correct and fsck passes.
>   Funny. Not sure how that could happen...

Yeah, strange. I looked at the code a bit and I don't see anything
obvious, ext3 seems to be using the same standard buffer head access
methods for the htree as for the rest of the metadata, and I see no
fancy playing with virtual addresses that could explain a VIVT problem.

I could be an issue with the SATA controller that gets more easily
triggered by the access patterns caused by htree, though that's a bit
strange.

I'll let you know when I have something to look at.

Cheers,
Ben.
