From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 22:52:28 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <555CF17D.4060500@free.fr>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <20150520201438.GW2067@n2100.arm.linux.org.uk> <555CF17D.4060500@free.fr>
Message-ID: <76003699.Oyq777txnm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 22:41:33 Mason wrote:
> 
> Oh... I didn't even think it made sense (and was supported)
> to select more than one machine...
> 
> Is this related to CONFIG_ARCH_MULTIPLATFORM?

Yes. In the old days, each platform had its own entry in the top-level
choice statement, which meant they were mutually exclusive. Most of
them are converted now and can be put into a single kernel with
CONFIG_ARCH_MULTIPLATFORM, and we stopped accepting new ones that
don't do this a few years ago.

I have a patch series that converts all remaining ARMv6 and ARMv7
platforms that don't are still standalone to use CONFIG_ARCH_MULTIPLATFORM
as well.

	Arnd
