From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Jan 2014 06:14:05 -0800
Subject: NFS client broken in Linus' tip
In-Reply-To: <20140130140834.GW15937@n2100.arm.linux.org.uk>
References: <20140130140834.GW15937@n2100.arm.linux.org.uk>
Message-ID: <20140130141405.GA23985@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 02:08:34PM +0000, Russell King - ARM Linux wrote:
> into nfs3_proc_create(), but this ends up calling down into nfs3_get_acl(),
> which does this:
> 
>         if (!nfs_server_capable(inode, NFS_CAP_ACLS))
>                 return ERR_PTR(-EOPNOTSUPP);

Does replacing that return with a

		return NULL;

fix the issue for you?
