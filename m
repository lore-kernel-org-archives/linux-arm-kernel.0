From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 23:22:51 +0800
Subject: [PATCH 1/4] [ARM] Remove now unnecessary dma_needs_bounce()
In-Reply-To: <4C1EFABC.4020601@compulab.co.il>
References: <1275724538-5075-1-git-send-email-eric.y.miao@gmail.com>
	<1275724538-5075-2-git-send-email-eric.y.miao@gmail.com>
	<AANLkTilJ3UpyHEplDqS_nV8SVDcl_pRRn4glDn7JS1GW@mail.gmail.com>
	<4C1EFABC.4020601@compulab.co.il>
Message-ID: <AANLkTimugHXfVUcEmq_DwaSLwelvnS9QoDJcxJaphahJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/21 Mike Rapoport <mike@compulab.co.il>:
> Eric
>
> Eric Miao wrote:
>>
>> On Sat, Jun 5, 2010 at 3:55 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>>
>>> With a correct dev->dma_mask before calling dmabounce_register_dev(),
>>> dma_needs_bounce() is not necessary.
>>>
>>> The above is true for it8152.c and ixp4xx/common-pci.c.
>>>
>>> The sa1111, though, is a bit complicated. Until it's fully understood
>>> and fixed, dma_needs_bounce() for sa1111 is kept if CONFIG_SA1111 is
>>> enabled with no side effect (with the condition of machine_is_*)
>>>
>>
>> Sorry I forgot to CC you two. Any feedback is welcome, thanks.
>
> Can I pull these changes from your git tree?

Sorry, just pushed them to the branch below:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
defconfig_cleanup
