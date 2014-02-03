From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 3 Feb 2014 06:57:59 -0800
Subject: NFS client broken in Linus' tip
In-Reply-To: <85AAFCF5-60EE-42E5-B103-37A4613C5947@primarydata.com>
References: <20140130140834.GW15937@n2100.arm.linux.org.uk>
 <20140130141405.GA23985@infradead.org>
 <20140130142752.GX15937@n2100.arm.linux.org.uk>
 <20140130143208.GB9573@infradead.org>
 <20140130153812.GA15937@n2100.arm.linux.org.uk>
 <1391201970.6978.1.camel@leira.trondhjem.org>
 <20140203080325.GB806@infradead.org>
 <85AAFCF5-60EE-42E5-B103-37A4613C5947@primarydata.com>
Message-ID: <20140203145759.GA30263@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 09:17:30AM -0500, Trond Myklebust wrote:
> As I said above, that causes posix_acl_xattr_get() to return the wrong answer (ENODATA instead of EOPNOTSUPP).

Is it really the wrong answer?  How does userspace care wether this
server doesn't support ACLs at all or none is set?  The resulting
behavior is the same.

If there's a good reason to care we might have to go with your patch,
but if we can avoid it I'd prefer to keep things simple.
