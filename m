From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Dec 2013 12:19:12 +0000
Subject: [RFC 07/18] regmap: debugfs: Always create "registers" &
 "access" files
In-Reply-To: <1387815830-8794-8-git-send-email-pawel.moll@arm.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-8-git-send-email-pawel.moll@arm.com>
Message-ID: <20131224121912.GX30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 04:23:39PM +0000, Pawel Moll wrote:
> When a map covers a single register, max_register is equal
> to 0, so the "registers" & "access" files were not created.
> 
> This patch is removing this restriction. It should be save,
> as the maps not without register 0 should return false
> for regmap_readable(map, 0).

No, we need to find a better way of doing this such as checking to see
if register zero is accessible in some way.  We want to avoid having
those files if there's no way of populating them since this is useful
information for tooling.
