From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Jun 2013 16:36:33 +1000
Subject: linux-next: Tree for May 30
In-Reply-To: <CAMuHMdXNzmJtfxzzt3kuzROzJmfsTKkp_4_8pdg=ahLv2LdU+Q@mail.gmail.com>
References: <20130530163334.105322d3c166b74165f1dad4@canb.auug.org.au>
 <CAMuHMdXNzmJtfxzzt3kuzROzJmfsTKkp_4_8pdg=ahLv2LdU+Q@mail.gmail.com>
Message-ID: <20130603163633.e392dffdacc316b490b12a26@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Thu, 30 May 2013 10:07:48 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> The following defconfigs fail without anything useful in the log:
>   - at91sam9g20_defconfig
>   - at91sam9261_defconfig
>   - at91sam9260_defconfig
> 
> A manual run reveals why:
> Can't find default configuration "arch/arm/configs/at91sam9g20_defconfig"!
> 
> This is due to the merge of several config files:
> 
> commit b3f442b0eedbc20b5ce3f4a96530588d14901199
> Author: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Date:   Wed May 15 17:19:21 2013 +0200
> 
>     ARM: at91: udpate defconfigs
> 
>     Merge 9g20 with 9260 and 9g10 with 9261 as those SoCs can run from the same
>     kernel even in non DT world.
> 
>     Fix the sam9261ek to allow 9g10 and sam9261 to compile together.
> 
>     Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>     Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks for letting me know.  I have stopped those three configs from
being built.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130603/317cceb2/attachment-0001.sig>
