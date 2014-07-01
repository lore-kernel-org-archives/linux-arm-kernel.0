From: phil@nwl.cc (Phil Sutter)
Date: Tue, 1 Jul 2014 17:29:39 +0200
Subject: [PATCH 1/2] [v3] crypto: sha1/ARM: make use of common SHA-1
 structures
In-Reply-To: <20140630163845.32348.80374.stgit@localhost6.localdomain6>
References: <20140630163845.32348.80374.stgit@localhost6.localdomain6>
Message-ID: <20140701152939.GC8243@orbit.nwl.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 30, 2014 at 07:38:46PM +0300, Jussi Kivilinna wrote:
> Common SHA-1 structures are defined in <crypto/sha.h> for code sharing.
> 
> This patch changes SHA-1/ARM glue code to use these structures.

I find it worth noting that this patch also fixes mv_cesa if sha1-arm is
also enabled. This is because software SHA1 is used as fallback,
accessing the context's data which was layed out differently before this
patch.

I have not checked, but other crypto engine drivers might be affected by
that, as well.

> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Jussi Kivilinna <jussi.kivilinna@iki.fi>

Acked-by: Phil Sutter <phil@nwl.cc>

Best wishes, Phil
