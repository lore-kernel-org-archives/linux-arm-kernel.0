From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Thu, 20 Aug 2015 09:33:12 +0200
Subject: [PATCH v3 08/20] block/xen-blkfront: split get_grant in 2
In-Reply-To: <1438966019-19322-9-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-9-git-send-email-julien.grall@citrix.com>
Message-ID: <55D582B8.5030602@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 07/08/15 a les 18.46, Julien Grall ha escrit:
> Prepare the code to support 64KB page granularity. The first
> implementation will use a full Linux page per indirect and persistent
> grant. When non-persistent grant is used, each page of a bio request
> may be split in multiple grant.
> 
> Furthermore, the field page of the grant structure is only used to copy
> data from persistent grant or indirect grant. Avoid to set it for other
> use case as it will have no meaning given the page will be split in
> multiple grant.
> 
> Provide 2 functions, to setup indirect grant, the other for bio page.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>

Thanks, this looks fine:

Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

Roger.
