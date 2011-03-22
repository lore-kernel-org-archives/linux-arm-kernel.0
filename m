From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Mar 2011 14:15:03 +0100
Subject: [PATCH v17 08/13] davinci: eliminate use of IO_ADDRESS() on sysmod
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C47D7B5@dbde02.ent.ti.com>
References: <1300197523-4574-1-git-send-email-manjunath.hadli@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C47D7B5@dbde02.ent.ti.com>
Message-ID: <201103221415.03904.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 March 2011, Nori, Sekhar wrote:
> .. but forgot to fix this. There is nothing wrong with
> using writel, but it doesn't fit into what the subject
> of this patch is.

Well, to be more exact, the __raw_writel was actually
wrong here and it should be writel(), but it's certainly
better to mention the reason in the changelog, or to
make a separate patch for it.

	Arnd
