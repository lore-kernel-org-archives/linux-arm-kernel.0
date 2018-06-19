From: joe@perches.com (Joe Perches)
Date: Tue, 19 Jun 2018 15:37:36 -0700
Subject: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded name
In-Reply-To: <CAHp75VcKuqnUgynqXvACS7zY5=6aRxqymGE1w3Yh8sshehSm2g@mail.gmail.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
 <CAHp75VcKuqnUgynqXvACS7zY5=6aRxqymGE1w3Yh8sshehSm2g@mail.gmail.com>
Message-ID: <3013aae1803c096645887864d1b161efbfba7c77.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-06-20 at 00:36 +0300, Andy Shevchenko wrote:
> On Mon, Jun 18, 2018 at 2:08 PM, Radhey Shyam Pandey
> <radhey.shyam.pandey@xilinx.com> wrote:
> > Switch hardcoded function name with a reference to __func__ making
> > the code more maintainable. Address below checkpatch warning:
> > 
> > WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
> > this function's name, in a string
> > +               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
> > 
> > WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
> > this function's name, in a string
> > +               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
> > 
> 
> For dev_dbg() the __func__ should be completely dropped away.

Not really the same.

dev_dbg without CONFIG_DYNAMIC_DEBUG does not have
the ability to prefix __func__.
