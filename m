From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 12 Aug 2010 04:43:24 +0200
Subject: [PATCH] ARM: Fix gen_nand probe structures contents
In-Reply-To: <1281576112.12475.15.camel@localhost>
References: <1281575694-17551-1-git-send-email-marek.vasut@gmail.com>
	<1281576112.12475.15.camel@localhost>
Message-ID: <201008120443.24749.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 12. srpna 2010 03:21:52 David Woodhouse napsal(a):
> On Thu, 2010-08-12 at 02:14 +0100, Marek Vasut wrote:
> > These three platforms didn't properly fill nr_chips in gen_nand
> > registration and
> > therefore depended on gen_nand bug fixed by the following patch:
> > 
> > "mtd: gen_nand: fix support for multiple chips"
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> 
> Thanks. I've applied that to the mtd-2.6.git tree, which has a few
> straggling commits I'll be asking Linus to pull shortly.
> 
> In case there are any more, would you care to complement it with a check
> in the driver that detects the nonsensical case of nr_chips == 0,
> assumes it means 1, and also warns about it?

I checked whole arch-arm and there are no more. nr_chips check would be a nice 
thing, I was thinking of it already when I sent the first patch. I just checked 
the other archs and there are more breaks. I'll implement the check in a 
separate patch.
