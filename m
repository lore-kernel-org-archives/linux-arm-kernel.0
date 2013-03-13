From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 13 Mar 2013 11:13:07 -0600
Subject: [PATCH] ARM: mvebu: fix RAM size for Armada XP board DB-MV784MP-GP
In-Reply-To: <20130313145419.GP12700@titan.lakedaemon.net>
References: <20130216164457.GA23237@titan.lakedaemon.net>
 <1363101135-21635-1-git-send-email-jason@lakedaemon.net>
 <51408D86.6040703@cogentembedded.com>
 <20130313143913.GN12700@titan.lakedaemon.net>
 <51409063.8080308@free-electrons.com>
 <20130313145419.GP12700@titan.lakedaemon.net>
Message-ID: <20130313171307.GC24042@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 10:54:19AM -0400, Jason Cooper wrote:

> > I was wrong in my initial version, all we can do in 32 bits is not
> > 4GB but 4GB-1B: reg = <0x00000000 0xFFFFFFFF>
> 
> hmmm, with the impending conquering of the server market by ARM, you'd
> think we'd at least be able to parse a 64 bit integer...

AFAIK, it would be like this:

/ {
        #address-cells = <2>;
        #size-cells = <2>;
        memory {
                device_type = "memory";
                reg = <0 0  1 0>;
        };

And the other children nodes must be revised to support the 2 dw
address and size..

Regards,
Jason
