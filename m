From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 3 Feb 2014 00:03:25 -0800
Subject: NFS client broken in Linus' tip
In-Reply-To: <1391201970.6978.1.camel@leira.trondhjem.org>
References: <20140130140834.GW15937@n2100.arm.linux.org.uk>
 <20140130141405.GA23985@infradead.org>
 <20140130142752.GX15937@n2100.arm.linux.org.uk>
 <20140130143208.GB9573@infradead.org>
 <20140130153812.GA15937@n2100.arm.linux.org.uk>
 <1391201970.6978.1.camel@leira.trondhjem.org>
Message-ID: <20140203080325.GB806@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 03:59:30PM -0500, Trond Myklebust wrote:
> posix_acl_xattr_get requires get_acl() to return EOPNOTSUPP if the
> filesystem cannot support acls. This is needed for NFS, which can't
> know whether or not the server supports acls until it tries to get/set
> one.
> This patch converts posix_acl_chmod and posix_acl_create to deal with
> EOPNOTSUPP return values from get_acl().

Shouldn't NFS just return a NULL ACL here?
