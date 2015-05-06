From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 6 May 2015 18:17:12 +0200
Subject: How to encode being an I2C slave in DT?
In-Reply-To: <554922EF.3050906@wwwdotorg.org>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <20150403194635.GC2016@katana> <1549160.njMIY2NVTi@fb07-iapwap2>
 <20150505105513.GA1841@katana> <554922EF.3050906@wwwdotorg.org>
Message-ID: <20150506161712.GA4003@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The container node has a #address-cells property for this very reason. It's
> perfectly well-defined how to split up a property containing a large number
> of cells into separate values, by using the value of #address-cells. Plus,
> the canonical formatting (albeit not enforced by the DT compiler) for a
> property that contains an array of entries, each 2 cells in size, would be:
> 
> reg = <0 0x1a>, <0 0x40>, <0 0x48>;
> 
> rather than:
> 
> reg = <0 0x1a 0 0x40 0 0x48>;
> 
> ... so it's quite simple to make it very human-readable too.

I give in to the flag idea. I also noticed that we'd need another flag
anyhow to mark 10 bit addresses. I am still thinking between using two
address-cells in that case (clean seperation between address and flags)
or to encode the flags as MSB in the current address (all busses will
have same address-cells and child description, less code paths and no
overhead in dtbs).

That being said, for the loopback testcase, the I2C slave framework will
need updates as well. I think I can cook up something. Will be
interesting to see if my hardware can do this. Has the loopback already
been tested on Tegra?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/faec8eb4/attachment-0001.sig>
