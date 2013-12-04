From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Dec 2013 11:49:09 +0000
Subject: [PATCH v4 1/3] mfd: tps6586x: add version detection
In-Reply-To: <20131204100728.GA907@lee--X1>
References: <cover.1386108712.git.stefan@agner.ch>
 <77384d24810d9a22fc04cad6f7468f54a9cbaafe.1386108712.git.stefan@agner.ch>
 <20131204081021.GB7469@lee--X1>
 <e2ae7b9602d0c1e11f8e56ced17e9da0@agner.ch>
 <20131204100728.GA907@lee--X1>
Message-ID: <20131204114909.GK29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 10:07:28AM +0000, Lee Jones wrote:
> On Wed, 04 Dec 2013, Stefan Agner wrote:

> > As I pointed out in the comment above, the struct tps6586x is in the C
> > file, so I would need to move that too. That's why I did not made that
> > change in the end. What do you think, should I still move (and move the
> > struct too?) 

> Why would the struct have to be moved if the function is inline?

If the function is in the header and trying to use a struct that's only
defined in the C file then it's not going to build - keeping the struct
in the C file only does seem like a worthwhile thing for encapsulation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/971a8602/attachment.sig>
