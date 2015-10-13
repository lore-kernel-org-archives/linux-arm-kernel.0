From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 14:44:49 +0200
Subject: [PATCH 2/5] arm: dts: lpc32xx: fix improper usage of ranges
 property
In-Reply-To: <1444694045-22000-3-git-send-email-vz@mleia.com>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
 <1444694045-22000-3-git-send-email-vz@mleia.com>
Message-ID: <7277011.vmOGiecsKn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 02:54:02 Vladimir Zapolskiy wrote:
> The change corrects invalid custom translations to 1:1 translations,
> otherwise during initialization there are too many failed attempts to
> translate addresses from subnodes, which anyway result in fallback 1:1
> translations, also it is found that due to this problem proper usage
> of ranges property in subnodes (e.g. for defining flash partitions)
> can not be done.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> 

I don't get it. What kind of errors do you see? The existing
version looks cleaner than the new one, as it only translates
the MMIO areas that are actually used.

	Arnd
