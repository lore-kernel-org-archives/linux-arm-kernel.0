From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Dec 2012 16:43:39 -0800
Subject: [PATCH] ARM: dts: fix split memory bank for SSDK5440
In-Reply-To: <3158118.uctD3XVWRG@flatron>
References: <1356030217-5472-1-git-send-email-kgene.kim@samsung.com>
 <1464138.NEt7mMkYJc@flatron> <50D38F04.8020307@gmail.com>
 <3158118.uctD3XVWRG@flatron>
Message-ID: <01f901cddf14$39f04500$add0cf00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> On Thursday 20 of December 2012 14:19:48 Subash Patel wrote:
> > I would like to ask a question here. Do we need to have sparse even if
> > the physical memory is contiguous? All the recent exynos machines come
> > with physical banks without any holes, and I am thinking why not drop it
> > and use flat mem instead. With LPAE these sections sizes wont be useful,
> > and I dont like to keep different section sizes for different
> > configurations. Any suggestions/opinions are very much helpful to me.
> 
> Since sparse memory is the only option available on Exynos currently in
> kernel configuration, I assume there was a reason for it. However I am not
> an expert in memory management, so please correct me if I am wrong.
> 
Hmm...yeah, as Subash said, it's no problem to disable sparsemem on EXYNOS
for now but memory hole can be existing on upcoming EXYNOS such as S5PV210
so keeping sparsemem would be better I think.

- Kukjin
