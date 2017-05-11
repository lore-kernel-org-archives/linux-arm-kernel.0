From: tj@kernel.org (Tejun Heo)
Date: Thu, 11 May 2017 10:45:26 -0400
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
In-Reply-To: <f529e2d1-68e0-2760-3fd0-c7b0e94dd003@arm.com>
References: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
 <CACRpkdasvjBPcr5RrPwtTYaoGeTEJMWqXbSRaB5-cOEKXbpfRg@mail.gmail.com>
 <f529e2d1-68e0-2760-3fd0-c7b0e94dd003@arm.com>
Message-ID: <20170511144526.GA30473@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, May 11, 2017 at 03:20:58PM +0100, Andre Przywara wrote:
> > Tejun, do I read your comments on the patch as an ACK?
> 
> Tejun and I were wondering why we need this "create an array with the
> indices" in the first place. If we can just call radix_tree_delete()
> directly from the radix_tree_for_each_slot() loop, we can have a much
> better fix (omitting the memory allocation at all)

Yeah, it doesn't make sense to allocate to destroy a radix tree.  It'd
be much better to cleanup the code so that it doesn't need allocation
in the first place.

Thanks.

-- 
tejun
