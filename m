From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 15:24:12 +0000
Subject: Hangs in libhugetlbfs tests in -next
Message-ID: <20150128152412.GX21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For at least the past couple of days tests of libhugetlbfs have been
hanging on mustang in the mlock test running ARMv8 defconfig with both
32 bit and 64 bit userspace - after the mprotect test (the one before
it) we get no console output for several hours so it appears that the
test has deadlocked.  The tail of the log is:

| find_path (2M: 64):	PASS
| unlinked_fd (2M: 64):	PASS
| readback (2M: 64):	PASS
| truncate (2M: 64):	PASS
| shared (2M: 64):	PASS
| mprotect (2M: 64):	PASS

and then a timeout.

This may be a generic bug but my ability to run these tests on other
platforms with huge page support using the infrastructure I'm using is
limited so I've not been able to test elsewhere and confirm.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/df17921d/attachment.sig>
