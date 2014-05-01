From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 1 May 2014 10:34:07 -0600
Subject: [RFC PATCH 0/3] mtd: nand: add randomizer support
In-Reply-To: <1398906592-24677-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1398906592-24677-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140501163407.GB3296@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 03:09:49AM +0200, Boris BREZILLON wrote:
> Hello,
> 
> This series is a proposal to add support for randomizers (either software
> or hardware) to NAND flash controller drivers.

FWIW, I think the term for reversibly combining a PRBS with data is
'scrambling', it is often used in communication systems for similar
reasons - probabilisticly increasing transition density.

randomizing is something else entirely :)

BTW, there are security concerns here. The scrambler PRBS must not be
predictable by the user, otherwise they can write data that undoes the
scramble and defeat it, ie deliberately writing the last 2k of a 4k
write block as all 0's after scrambling could cause the first 2k to be
lost. That feels like something that could be scary ..

Jason
