From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Apr 2011 19:33:25 +0100
Subject: [PATCH 2/9] ARM: pxa: enable sparsemem in saarb
In-Reply-To: <AANLkTikdCoHg57f9FY3kc3RbddsVUUfgkk=VJibv65QS@mail.gmail.com>
References: <1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTimf+s7NNGc=SczGjeXNP_5VYFfALC65DZ8FSEvq@mail.gmail.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C05CEEB84A9@SC-VEXCH1.marvell.com>
	<AANLkTikdCoHg57f9FY3kc3RbddsVUUfgkk=VJibv65QS@mail.gmail.com>
Message-ID: <20110401183325.GB8482@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2011 at 01:10:52PM +0800, Eric Miao wrote:
> On Fri, Apr 1, 2011 at 12:35 PM, Haojian Zhuang <hzhuang1@marvell.com> wrote:
> > If I use HIGHMEM now, our some drivers and apps should be changed also. We don't want to change them.
> 
> I don't understand this will cause side effects to other drivers and apps?

If they're not using kmap_atomic() but are dealing directly with
page addresses, they'll fail if the pages are coming from highmem.

Given Linus' complaints in the OMAP pull request thread, I think we
should refuse, and have the drivers fixed to work with highmem.
