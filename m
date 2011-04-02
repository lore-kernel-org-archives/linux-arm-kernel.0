From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 2 Apr 2011 14:48:54 +0800
Subject: [PATCH 2/9] ARM: pxa: enable sparsemem in saarb
In-Reply-To: <20110401183325.GB8482@n2100.arm.linux.org.uk>
References: <1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTimf+s7NNGc=SczGjeXNP_5VYFfALC65DZ8FSEvq@mail.gmail.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C05CEEB84A9@SC-VEXCH1.marvell.com>
	<AANLkTikdCoHg57f9FY3kc3RbddsVUUfgkk=VJibv65QS@mail.gmail.com>
	<20110401183325.GB8482@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=2VfUTb3ne3LtTa851roJXZeg1CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 2, 2011 at 2:33 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 01, 2011 at 01:10:52PM +0800, Eric Miao wrote:
>> On Fri, Apr 1, 2011 at 12:35 PM, Haojian Zhuang <hzhuang1@marvell.com> wrote:
>> > If I use HIGHMEM now, our some drivers and apps should be changed also. We don't want to change them.
>>
>> I don't understand this will cause side effects to other drivers and apps?
>
> If they're not using kmap_atomic() but are dealing directly with
> page addresses, they'll fail if the pages are coming from highmem.
>
> Given Linus' complaints in the OMAP pull request thread, I think we
> should refuse, and have the drivers fixed to work with highmem.
>

That's what I thought as well.

Haojian,

Please work on enabling highmem, anything that's going to prevent
us from having a single kernel binary, will just make the situation
worse. Thanks
