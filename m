From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 07 Mar 2012 13:11:13 +0100
Subject: [PATCH v4] mm: cma: add a simple kernel module as the helper to
 test CMA
In-Reply-To: <1331120259-30780-1-git-send-email-Barry.Song@csr.com>
References: <1331120259-30780-1-git-send-email-Barry.Song@csr.com>
Message-ID: <op.wasuszai3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Mar 2012 12:37:39 +0100, Barry Song <Barry.Song@csr.com> wrote:
> Any write request to /dev/cma_test will let the module to allocate memory from
> CMA, for example:
>
> 1st time
> $ echo 1024 > /dev/cma_test
> will require cma_test to request 1MB(1024KB)
> 2nd time
> $ echo 2048 > /dev/cma_test
> will require cma_test to request 2MB(2048KB)
>
> Any read request to /dev/cma_test will let the module to free the 1st valid
> memory from CMA, for example:
>
> 1st time
> $ cat /dev/cma_test
> will require cma_test to free the 1MB allocated in the first write request
> 2nd time
> $ cat /dev/cma_test
> will require cma_test to free the 2MB allocated in the second write request
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Reviewed-by: Michal Nazarewicz <mina86@mina86.com>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
