From: clabbe@baylibre.com (LABBE Corentin)
Date: Mon, 10 Sep 2018 20:53:25 +0200
Subject: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
In-Reply-To: <a1795266-5679-289d-5cce-1111babf3180@c-s.fr>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
 <a1795266-5679-289d-5cce-1111babf3180@c-s.fr>
Message-ID: <20180910185325.GC7819@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 07:22:04AM +0200, Christophe LEROY wrote:
> 
> 
> Le 07/09/2018 ? 21:41, Corentin Labbe a ?crit?:
> > This patch adds setbits32/clrbits32/clrsetbits32 and
> > setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> 
> So you changed the name of setbits32() ... to setbits32_be() and now you 
> are adding new functions called setbits32() ... which do something 
> different ?
> 
> What will happen if any file has been forgotten during the conversion, 
> or if anybody has outoftree drivers and missed this change ?
> They will silently successfully compile without any error or warning, 
> and the result will be crap buggy.
> 
> And why would it be more legitim to have setbits32() be implicitely LE 
> instead of implicitely BE ?
> 
> I really think those new functions should be called something like 
> setbits_le32() ...
> 

I believed that writel/readl was endian agnostic so it explain my mistake.

I will use xxxbits_le32 as you requests.

Thanks
Regards
