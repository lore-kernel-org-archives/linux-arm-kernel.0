From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 22:30:18 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <519CEAAF.2050600@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221743.47679.arnd@arndb.de> <519CEAAF.2050600@free-electrons.com>
Message-ID: <201305222230.18848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 May 2013, Gregory CLEMENT wrote:
> But you proposed to use device tree instead of CP15. In this case we won't be
> able to use earlyprintk that was my point. You justified the fact to not use
> earlyprintk because we can't use it for multiplatform. So I am fine to not being
> able to use earlyprintk in multiplatform, but it sill important to be able to
> continue to use in non multiplatform case, hence the need of the use of CP15
> bit.

The use of devicetree would only be for the regualar kernel operation, not
for DEBUG_LL. DEBUG_LL can easily be hardcoded.

	Arnd
