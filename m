From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Mon, 14 Mar 2016 09:22:37 +0200
Subject: [PATCH] media: add GFP flag to media_*() that could get called
 in atomic context
In-Reply-To: <1457833689-4926-1-git-send-email-shuahkh@osg.samsung.com>
References: <1457833689-4926-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <20160314072236.GO11084@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

On Sat, Mar 12, 2016 at 06:48:09PM -0700, Shuah Khan wrote:
> Add GFP flags to media_create_pad_link(), media_create_intf_link(),
> media_devnode_create(), and media_add_link() that could get called
> in atomic context to allow callers to pass in the right flags for
> memory allocation.
> 
> tree-wide driver changes for media_*() GFP flags change:
> Change drivers to add gfpflags to interffaces, media_create_pad_link(),
> media_create_intf_link() and media_devnode_create().
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> Suggested-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

What's the use case for calling the above functions in an atomic context?

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
