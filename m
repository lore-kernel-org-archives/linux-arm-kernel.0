From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 17:20:10 +0100
Subject: [PATCH 0/6] arm64: alternatives runtime patching
In-Reply-To: <1415980452-20366-1-git-send-email-andre.przywara@arm.com>
References: <1415980452-20366-1-git-send-email-andre.przywara@arm.com>
Message-ID: <2041011.PXfvHs4Xp7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 15:54:06 Andre Przywara wrote:
> This series introduces alternatives runtime patching to arm64.
> This allows to patch assembly instruction at runtime to either
> fix hardware bugs or optimize for certain hardware features. Look
> at patch 5/6 for an example on how to use this.
> 

Does it provide a measurable performance benefit? The implementation
seems ok, but we should only add the complexity for things that
actually need it and can't be handled just as well with a run-time
conditional.

	Arnd
