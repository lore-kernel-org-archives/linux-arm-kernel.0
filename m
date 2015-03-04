From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 4 Mar 2015 07:47:21 +0100
Subject: Bug in i2c-core?
In-Reply-To: <3574616.qzNqihiGp7@avalon>
References: <54F0507F.6030804@armadeus.com> <20150227165944.GA6679@dtor-ws>
 <3574616.qzNqihiGp7@avalon>
Message-ID: <20150304064721.GA883@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Yes, this commit breaks all drivers using devm* for IRQ management on
> > OF-based systemsi because devm* cleanup happens in device code, after
> > bus's remove() method returns. I'd recommend reverting and finding a
> > better way (making cleanup a custom devm action as well?).
> 
> Ouch, my bad.
> 
> Wolfram, any opinion ? The original patch fixes a real bug, so we shouldn't 
> just revert it.

I guess the usual rules apply. Let's try to fix it for v4.0, otherwise I
have to revert it.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/3ee92e4f/attachment.sig>
