From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Aug 2010 02:21:52 +0100
Subject: [PATCH] ARM: Fix gen_nand probe structures contents
In-Reply-To: <1281575694-17551-1-git-send-email-marek.vasut@gmail.com>
References: <1281575694-17551-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1281576112.12475.15.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-08-12 at 02:14 +0100, Marek Vasut wrote:
> These three platforms didn't properly fill nr_chips in gen_nand
> registration and
> therefore depended on gen_nand bug fixed by the following patch:
> 
> "mtd: gen_nand: fix support for multiple chips"
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com> 

Thanks. I've applied that to the mtd-2.6.git tree, which has a few
straggling commits I'll be asking Linus to pull shortly.

In case there are any more, would you care to complement it with a check
in the driver that detects the nonsensical case of nr_chips == 0,
assumes it means 1, and also warns about it?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
