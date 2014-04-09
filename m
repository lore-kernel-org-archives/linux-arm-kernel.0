From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Apr 2014 11:20:28 -0300
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <20140409133422.GA2334@dragon>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
 <20140409133422.GA2334@dragon>
Message-ID: <CAOMZO5CO8ucya8qmVXBo5kgRmuLqKGtpub07o1DuE9yh5LmmPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 10:34 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

> I'm not sure this is a full/correct fix to the problem.  You assume that
> the re-parenting only happens during boot for once?  What about the

Yes, correct. As far as I can see LDB parent is only set once in clk-imx6q.

> re-parenting triggered by the clk_set_parent() call?

Where do you see the LDB clock parent to change via clk_set_parent() call?

In imx_ldb.c we use clk_set_parent() to set the di parent, not ldb parent.
