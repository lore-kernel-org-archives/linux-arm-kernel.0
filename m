From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Oct 2018 10:56:56 +0100
Subject: [PATCH v2 1/3] driver core: add probe_err log helper
In-Reply-To: <20181017085824.30806-1-a.hajda@samsung.com>
References: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
 <CGME20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f@eucas1p2.samsung.com>
 <20181017085824.30806-1-a.hajda@samsung.com>
Message-ID: <20181017095656.GC24097@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 10:58:24AM +0200, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:

Reviwed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181017/c8603fbe/attachment.sig>
