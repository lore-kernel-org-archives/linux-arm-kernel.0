From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Dec 2014 16:42:58 +0100
Subject: [PATCH 5/5] ARM: mvebu: Add Armada 385 Access Point Development
 Board support
In-Reply-To: <1417790698-9792-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1417790698-9792-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <2227568.Fzikh3bS7J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 December 2014 15:44:58 Maxime Ripard wrote:
> +       chosen {
> +               bootargs = "console=ttyS0,115200 earlyprintk";
> +       };

We should stop using earlyprintk as the default bootargs. It's always been
problematic in case you have a kernel that contains the wrong debug_ll
stub, and starting from 3.19, we should have a working earlycon support.

	Arnd
