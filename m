From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 12 Nov 2016 18:45:30 +0100 (CET)
Subject: [PATCH v2] staging: vc04_services: rework ioctl code path
In-Reply-To: <20161111061531.23507-1-mzoran@crowfest.net>
References: <20161111061531.23507-1-mzoran@crowfest.net>
Message-ID: <897162311.351896.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

> Michael Zoran <mzoran@crowfest.net> hat am 11. November 2016 um 07:15
> geschrieben:
> 
> 
> VCHIQ/vc04_services has a userland device interface
> that includes ioctls. The current ioctl implementation
> is a single monolithic function over 1,000+ lines
> that handles 17 different ioctls through a complex
> maze of switch and if statements.
> 
> The change reimplements that code path by breaking
> up the code into smaller, easier to maintain functions
> and uses a dispatch table to invoke the correct function.

nice. But please always use scripts/checkpatch.pl before submitting your
patches. 

And yes it is not necessary to fix all "line over 80 chars" warnings.
