From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Dec 2010 11:42:57 +0000
Subject: [PATCH 0/2] Support for __read_mostly
Message-ID: <20101205114257.GD9138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for __read_mostly - a separate section
which is used to hold data which is hardly ever written.

The idea behind this feature is to reduce the amount of cache line
bouncing between SMP cores by avoiding this data sharing cache lines
with data which is written more frequently.  As long as a cache line
is not dirtied, several cores can keep a copy of the data in their
caches.
