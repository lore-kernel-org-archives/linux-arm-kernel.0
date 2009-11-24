From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 24 Nov 2009 23:46:21 +0200
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091124210154.GI17481@n2100.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
	<1259081261.16239.28.camel@pc1117.cambridge.arm.com>
	<20091124200019.GH17481@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911241523130.2059@xanadu.home>
	<20091124210154.GI17481@n2100.arm.linux.org.uk>
Message-ID: <c70ff3ad0911241346v75fdd91g567b2205dfed1e96@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

btw, will it be necessary to invalidate a harvard caches when doing unmap?
if the speculative prefetch ends up with cache line that filled into
the icache, then no need invalidate it.
