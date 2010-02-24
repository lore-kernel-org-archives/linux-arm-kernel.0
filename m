From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 25 Feb 2010 08:12:34 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002240816.10178.oliver@neukum.org>
References: <1266445892.16346.306.camel@pasglop>
	<201002192153.22159.oliver@neukum.org>
	<1266979689.23523.1669.camel@pasglop>
	<201002240816.10178.oliver@neukum.org>
Message-ID: <1267045954.23523.1692.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-24 at 08:16 +0100, Oliver Neukum wrote:
> I don't know. The issue seems quite complex. It would seem better to
> centralize it as far as practical. Do you have a wrapper drivers could
> call?

flush_dcache_page() ? :-)

Now, the subsystem might be the one to know whether something is mapped
into userspace or not (v4l in our case) in which case a wrapper could be
created.

Cheers,
Ben.
