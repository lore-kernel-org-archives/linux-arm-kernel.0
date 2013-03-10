From: holler@ahsoftware.de (Alexander Holler)
Date: Sun, 10 Mar 2013 18:06:11 +0100
Subject: [PATCH v2] arm: fix memset-related crashes caused by recent GCC
 (4.7.2) optimizations
In-Reply-To: <20130307151755.GB4977@n2100.arm.linux.org.uk>
References: <1360587435-28386-1-git-send-email-ivan.djelic@parrot.com>
 <513795C5.4050608@gmail.com> <20130307151755.GB4977@n2100.arm.linux.org.uk>
Message-ID: <513CBD83.7040909@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.03.2013 16:17, schrieb Russell King - ARM Linux:
> On Wed, Mar 06, 2013 at 08:15:17PM +0100, Dirk Behme wrote:
>> Am 11.02.2013 13:57, schrieb Ivan Djelic:
>>> Recent GCC versions (e.g. GCC-4.7.2) perform optimizations based on
>>> assumptions about the implementation of memset and similar functions.
>>> The current ARM optimized memset code does not return the value of
>>> its first argument, as is usually expected from standard implementations.

I've just tried this patch with kernel 4.8.2 on an armv5-system where I 
use gcc 4.7.2 since several months and where most parts of the system 
are compiled with gcc 4.7.2 too.

And I had at least one problem which manifested itself with

[  181.198559] pts1: unknown flag 212

while trying to establish a btle-connection.

So I assume either the patch is wrong, the patch isn't the whole story, 
an existing bug is now triggered, or ...

I don't know.

Regards,

Alexander
