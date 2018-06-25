From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 25 Jun 2018 13:47:52 +0000
Subject: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded name
In-Reply-To: <3013aae1803c096645887864d1b161efbfba7c77.camel@perches.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
 <CAHp75VcKuqnUgynqXvACS7zY5=6aRxqymGE1w3Yh8sshehSm2g@mail.gmail.com>
 <3013aae1803c096645887864d1b161efbfba7c77.camel@perches.com>
Message-ID: <DM6PR02MB436155458BFAB5575207B2C4C74A0@DM6PR02MB4361.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Joe Perches [mailto:joe at perches.com]
> Sent: Wednesday, June 20, 2018 4:08 AM
> To: Andy Shevchenko <andy.shevchenko@gmail.com>; Radhey Shyam
> Pandey <radheys@xilinx.com>
> Cc: David S. Miller <davem@davemloft.net>; Andrew Lunn
> <andrew@lunn.ch>; Michal Simek <michals@xilinx.com>; netdev
> <netdev@vger.kernel.org>; linux-arm Mailing List <linux-arm-
> kernel at lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel at vger.kernel.org>
> Subject: Re: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded
> name
> 
> On Wed, 2018-06-20 at 00:36 +0300, Andy Shevchenko wrote:
> > On Mon, Jun 18, 2018 at 2:08 PM, Radhey Shyam Pandey
> > <radhey.shyam.pandey@xilinx.com> wrote:
> > > Switch hardcoded function name with a reference to __func__ making
> > > the code more maintainable. Address below checkpatch warning:
> > >
> > > WARNING: Prefer using '"%s...", __func__' to using
> 'xemaclite_mdio_read',
> > > this function's name, in a string
> > > +               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
> > >
> > > WARNING: Prefer using '"%s...", __func__' to using
> 'xemaclite_mdio_write',
> > > this function's name, in a string
> > > +               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
> > >
> >
> > For dev_dbg() the __func__ should be completely dropped away.
> 
> Not really the same.
> 
> dev_dbg without CONFIG_DYNAMIC_DEBUG does not have
> the ability to prefix __func__.
Yes.  If it's acceptable,  prefer to use __func__  to support all 
configurations

> 
