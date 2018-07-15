From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 16 Jul 2018 08:31:44 +1000
Subject: next/master boot: 184 boots: 13 failed, 171 passed (next-20180711)
In-Reply-To: <1bdd19e5-036d-0979-f360-14a43e3e986d@deltatee.com>
References: <5b45f6df.1c69fb81.86409.6375@mx.google.com>
 <20180711145253.GA9651@sirena.org.uk>
 <CAOMZO5B+LBwAEewEoCn=TojQuZ=qMt+4a8n+tiG9cfnzAta_9w@mail.gmail.com>
 <20180712100809.10ac3e1d@canb.auug.org.au>
 <20180714121046.7a9cdf20@canb.auug.org.au>
 <1bdd19e5-036d-0979-f360-14a43e3e986d@deltatee.com>
Message-ID: <20180716083144.499eb2c6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Logan,

On Fri, 13 Jul 2018 20:19:23 -0600 Logan Gunthorpe <logang@deltatee.com> wrote:
>
> On 13/07/18 08:10 PM, Stephen Rothwell wrote:
> > I have just imported the new mmotm, and that patch is still in there.
> > Has it been fixed, or do I need to remove it again?  (See the above
> > patchwork entry).  
> 
> It has not been fixed. The consensus was to drop it.
> 
> @Andrew: I think we should drop the entire series seeing there was
> another issue that cropped up earlier today after being in linux-next
> (from Guenter Roeck). I will submit an updated v19 when I have a chance.
> If you'd like me to handle this in a different way, let me know.

OK, so I have removed the following from linux-next today:

0b845db3ac65 ntb: ntb_hw_switchtec: cleanup 64bit IO defines to use the common header
6d997075ea14 crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
9d235749060f ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
1a516b53c12d io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
ddc62940244b iomap: introduce io{read|write}64_{lo_hi|hi_lo}
6f595ae8ed85 parisc: iomap: introduce io{read|write}64
b68c7928b65d iomap: use non-raw io functions for io{read|write}XXbe

Let me know if that is correct or otherwise.
-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180716/b16a9020/attachment.sig>
