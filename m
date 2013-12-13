From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 13 Dec 2013 11:04:15 +0000
Subject: [PATCH] ARM: shmobile: r8a7790 - fix shdi resource sies
In-Reply-To: <CANqRtoT86xdh-c73f-_59sD3E=90yW1wOp5Bobmi4qJywA72uA@mail.gmail.com>
References: <1386869040-20849-1-git-send-email-ben.dooks@codethink.co.uk>
 <871u1hsd44.wl%kuninori.morimoto.gx@gmail.com>
 <CANqRtoT86xdh-c73f-_59sD3E=90yW1wOp5Bobmi4qJywA72uA@mail.gmail.com>
Message-ID: <52AAE9AF.6010704@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/13 10:56, Magnus Damm wrote:
> Hey Morimoto-san,
>
> On Fri, Dec 13, 2013 at 11:37 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
>>
>> Hi Ben
>>
>> Thank you for your patch
>>
>>> The r8a7790.dtsi file has three sdhi nodes which all have the wrong resource
>>> size for their register block. This causes the sh_modbile_sdhi driver to
>>> fail to communicate with card at-all.
>>>
>>> Change each sdhi node size from 0x100 to 0x200 to correct this.
>>>
>>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>>> Cc: Magnus Damm <magnus.damm@gmail.com>
>>> Cc: Simon Horman <horms@verge.net.au>
>>> Cc: Linux SH <linux-sh@vger.kernel.org>
>>> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Tested-by: William Towle <william.towle@codethink.co.uk>
>>> ---
>>
>> Unfortunately, sdhi resource size 0x100 is corrent on Renesas SDHI.
>> The wrong is SDHI/TMIO driver side, not SoC side.
>> Now, I'm working/sending sh_modbile_sdhi driver fixup patches for R-Car H2,
>> but it need more time (= there is merge timing issue)
>
> Thanks for supporting Ben regarding this SDHI issue.
>
> Would it be possible for you to share a list of patches needed to get
> SDHI working? If some parts are missing then please post them so the
> patches are available on public lists.
>
> I would like to make it possible for Ben to test your patch stack if
> he happens to have time.

Thanks, I think I have all the previous ones that where pushed to the
linux-sh list. If there's a git tree I could pull from that would make
our job easier.

We have got SDHI0 and SDHI2 working with device tree, but we're
currently seeing less than a megabyte a second when direcly dd-ing
blocks from the card. Is this a noted issue? We got ~11MiB without
DMA on the 3.4-ltsi series.

As a note, I will be away from the 20th December untill Janurary 6th
and it is likely the rest of the team here will be away from 21st.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
