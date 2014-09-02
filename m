From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Sep 2014 09:52:34 +0200
Subject: [PATCH v2 10/12] clk: sunxi: mod0: Introduce MMC proper phase
 handling
In-Reply-To: <20140901213945.5251.37105@quantum>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-11-git-send-email-maxime.ripard@free-electrons.com>
 <20140901213945.5251.37105@quantum>
Message-ID: <20140902075234.GO15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 01, 2014 at 02:39:45PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-08-30 13:03:09)
> > The MMC clock we thought we had until now are actually not one but three
> > different clocks.
> > 
> > The main one is unchanged, and will have three outputs:
> >   - The clock fed into the MMC
> >   - a sample and output clocks, to deal with when should we output/sample data
> >     to/from the MMC bus
> > 
> > The phase control we had are actually controlling the two latter clocks, but
> > the main MMC one is unchanged.
> > 
> > We can adjust the phase with a 3 bits value, from 0 to 7, 0 meaning a 180 phase
> > shift, and the other values being the number of periods from the MMC parent
> > clock to outphase the clock of.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Looks good. Thanks a lot for revisiting this after talking to your
> hardware team!

It's not *our* hardware team, but I'll let them know :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/3984ede1/attachment-0001.sig>
