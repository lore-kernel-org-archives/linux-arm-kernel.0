From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 19 Feb 2013 14:48:47 +0000
Subject: [PATCH V2] xen: event channel arrays are xen_ulong_t and not
 unsigned long
Message-ID: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following two patches (one for Xen, one for Linux) switch Xen event
channels from unsigned long to xen_ulong_t.

On arm, this enables us to have the same interface on arm32 and arm64
because xen_ulong_t is a 64-bit type on ARM.

On x86 there is no change because xen_ulong_t is unsigned long on x86.

Since this is an ABI change on ARM I hope we can get this in for the 3.9
merge window. I have deferred the other changes which I previously
posted along side this since they are not so critical.

Ian.
