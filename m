From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Mar 2015 09:45:37 +0900
Subject: Possible regression in next-20150323 due to "ARM, arm64: kvm: get
 rid of the bounce page"
Message-ID: <20150324004537.GA24816@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I have observe what appears to be a build regression in next-20150323
caused by 06f75a1f62000 ("ARM, arm64: kvm: get rid of the bounce page").

# make
...
arm-unknown-linux-gnueabi-ld:./arch/arm/kernel/vmlinux.lds:546: syntax error

I have observed this using the cross-compiler that is available on kernel.org:

https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/

# arm-unknown-linux-gnueabi-gcc --version
arm-unknown-linux-gnueabi-gcc (GCC) 4.6.3
Copyright (C) 2011 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# arm-unknown-linux-gnueabi-ld --version
GNU ld (GNU Binutils) 2.22
Copyright 2011 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later version.
This program has absolutely no warranty.
