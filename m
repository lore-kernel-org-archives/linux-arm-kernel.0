From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 11:46:34 +0100
Subject: [PATCH 03/12] irqchip: gic: define register_routable_domain_ops
 conditional
In-Reply-To: <1417565531-4507-4-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-4-git-send-email-stefan@agner.ch>
Message-ID: <5174649.NxPq80uDz8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 01:12:02 Stefan Agner wrote:
> The inline function register_routable_domain_ops is only usable if
> CONFIG_ARM_GIC is set. Make it depend on this configuration. This
> also allows other SoC interrupt controller to provide such a
> function.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I don't think this is a good idea: either the interface is meant
to be generic and should work with any interrupt controller, or
it is specific to one irqchip and another irqchip should provide
a different interface that has a nonconflicting name.

I suppose you want the latter here, given that the declaration
is part of the gic specific header file.

	Arnd
