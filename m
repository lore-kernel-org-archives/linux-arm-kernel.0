From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 21 Oct 2012 14:00:04 +0300
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <CAN8TOE91TDewmo=w7585sDrsXcPmBnvOjmD7sTizPSJ8RH8_Gg@mail.gmail.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
 <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
 <CAOh2x=ksMr7VRCnpF-rK+Mesg1p4Td++SQ-t=ShrguRRVWSSSQ@mail.gmail.com>
 <CACRpkdYjA8QUh4HqvE1rsnXcGA4WafTkMq_wLNJ__gXEnEYrow@mail.gmail.com>
 <507794B6.2000107@st.com> <1350307104.4115.23.camel@sauron.fi.intel.com>
 <CAN8TOE-7d=YUSYsHFw9X5vnz8cpSJYv5uZfvBpDyhg+-F_LDiQ@mail.gmail.com>
 <CACRpkdao_9TkH7=ia7kXB-KsQhNZQ7EfSS5B1X0wFPgg5OsuHA@mail.gmail.com>
 <1350371685.5769.45.camel@sauron.fi.intel.com>
 <CACRpkdY2=PLS_MT1h_nQJj+2ju26yXtt-aXSi=t9uUQ5+WJasA@mail.gmail.com>
 <CAN8TOE91TDewmo=w7585sDrsXcPmBnvOjmD7sTizPSJ8RH8_Gg@mail.gmail.com>
Message-ID: <1350817204.1704.0.camel@kyv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-10-21 at 00:38 -0700, Brian Norris wrote:
> >> This is good idea, the problem is that it is a bit more work than
> >> hacking the driver, so most people prefer the latter. By removing all
> >> kmalloc()'s I basically wish to force people to go this way.
> 
> Did you mean vmalloc()'s?

Yes.

> 
> >> What are the SC functions names you refer?
> >
> > I'm mainly thinking of blk_rq_map_sg()
> > from block/blk-merge.c

Yeah, may be re-working or extending MTD api with SG lists would be the
way to go, but this is a lot more work...

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121021/243509aa/attachment.sig>
