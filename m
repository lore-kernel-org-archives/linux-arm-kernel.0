From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 22:17:43 +0100
Subject: [PATCH v2] ARM: vmlinux-xip.lds: assert that ROM and RAM don't
 overlap
In-Reply-To: <HK2PR06MB05619656241BFD0A9165B6C28AAD0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1455278803-27679-1-git-send-email-ard.biesheuvel@linaro.org>
 <HK2PR06MB05619656241BFD0A9165B6C28AAD0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <5611698.LJs5sAezys@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 19:18:51 Chris Brandt wrote:
> 
> This looks fine to me. I see no issues with it.
> Of course, this is for systems with a much tighter device memory layout than what I usually use.

The overlap should only happen when you have really large kernel images
over 16MB of readonly .text+.rodata, and I would assume this rarely happens
in practice.

	Arnd
