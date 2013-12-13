From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 13 Dec 2013 08:23:21 +0000
Subject: [PATCH] ARM: shmobile: r8a7790 - fix shdi resource sies
In-Reply-To: <871u1hsd44.wl%kuninori.morimoto.gx@gmail.com>
References: <1386869040-20849-1-git-send-email-ben.dooks@codethink.co.uk>
 <871u1hsd44.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <52AAC3F9.3050909@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/13 02:37, Kuninori Morimoto wrote:
>
> Hi Ben
>
> Thank you for your patch
>
>> The r8a7790.dtsi file has three sdhi nodes which all have the wrong resource
>> size for their register block. This causes the sh_modbile_sdhi driver to
>> fail to communicate with card at-all.
>>
>> Change each sdhi node size from 0x100 to 0x200 to correct this.
>>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Linux SH <linux-sh@vger.kernel.org>
>> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Tested-by: William Towle <william.towle@codethink.co.uk>
>> ---
>
> Unfortunately, sdhi resource size 0x100 is corrent on Renesas SDHI.
> The wrong is SDHI/TMIO driver side, not SoC side.
> Now, I'm working/sending sh_modbile_sdhi driver fixup patches for R-Car H2,
> but it need more time (= there is merge timing issue)

Ok, thanks. We will keep this in our tree until the SDHI driver
is sorted out.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
