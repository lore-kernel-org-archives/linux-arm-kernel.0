From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 24 Sep 2009 18:51:50 +0200
Subject: ixp4xx dmabounce
In-Reply-To: <a104b22c0909240902g31da6983w26be4526cbdfc16c@mail.gmail.com>
	(Brian Walsh's message of "Thu, 24 Sep 2009 12:02:25 -0400")
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
	<19129.24807.954274.688709@pilspetsen.it.uu.se>
	<m33a6dk9li.fsf@intrepid.localdomain>
	<a104b22c0909240902g31da6983w26be4526cbdfc16c@mail.gmail.com>
Message-ID: <m3ljk4xp3t.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian Walsh <brian@walsh.ws> writes:

> I tried Krzysztof's patch and it had no noticeable affect.  I am still getting
> about 6.3 Mbps IP data throughput when only using the ohci controller and
> about 3.6 Mbps when the device is attached to the ehci controller.  This
> device works fine when running the same testing attached to an x86
> configured machine and gets about 18 Mbps IP data throughput.

I assume you've enabled CONFIG_ZONE_DMA_ALL_KERNEL :-)

Either the bouncing isn't the problem in this case, or the allocations
are GFP_USER.
-- 
Krzysztof Halasa
