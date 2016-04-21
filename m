From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Thu, 21 Apr 2016 02:39:37 +0000
Subject: [PATCH 0/8] STMPE fixes/rework and add STMPE1600 support
In-Reply-To: <5717A833.3020304@wwwdotorg.org>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <5716545D.9080006@wwwdotorg.org> <5717325F.6080808@st.com>
 <5717A833.3020304@wwwdotorg.org>
Message-ID: <1461206376.4279.38.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-04-20 at 10:02 -0600, Stephen Warren wrote:
> On 04/20/2016 01:40 AM, Patrice Chotard wrote:
> > 
> > On 04/19/2016 05:53 PM, Stephen Warren wrote:
> > > 
> > > On 04/19/2016 06:18 AM, patrice.chotard at st.com wrote:
> > > > 
> > > > From: Patrice Chotard <patrice.chotard@st.com>
> > > > 
> > > > This series cleans and fixes some bugs in MFD/GPIO STMPE
> > > > drivers and
> > > > prepare
> > > > ? the ground to add new STMPE1600 support.
> > > > 
> > > > STMPE1600 datasheet is available here :
> > > > http://www2.st.com/content/st_com/en/products/interfaces-and-tr
> > > > ansceivers/
> > > > 
> > > > i-o-expanders-and-level-translators/i-o-
> > > > expanders/stmpe1600.html
> > > > 
> > > > Only STMPE1600 has been tested on STM32 platform. As i have no
> > > > board
> > > > with
> > > > others STMPE
> > > > variant(STMPE610/STMPE801/STMPE811/STMPE1601/STMPE1801/STMPE240
> > > > 1
> > > > and STMPE2403), i put in CC boards's maintainers which are
> > > > using
> > > > others STMPE variant.
> > > > 
> > > > If they can kindly check that no regression has been introduce
> > > > by
> > > > this series
> > > > 
> > > > For TEGRA ARCHITECTURE SUPPORT
> > > > ????_ Stephen Warren <swarren@wwwdotorg.org>
> > > > ????_ Thierry Reding <thierry.reding@gmail.com>
> > > > ????_ Alexandre Courbot <gnurou@gmail.com>
> > > I don't know what STMPE is, and I don't believe it is used on
> > > Tegra;
> > > what makes you think it is?
> ...
> > 
> > I put you in copy as STMPE811 is used on tegra30-apalis and
> > tegra30-colibri platforms.
> Ah. You'd best contact the individual board owners, since those are?
> 3rd-party Tegra boards and I don't believe anyone at NVIDIA has them
> to?
> test with etc. I added likely candidates to Cc and dropped all the?
> individuals unrelated to Tegra to keep the CC list low.

I gave the whole series a spin on Apalis T30 2GB V1.1A featuring a
STMPE811 and the EDT VGA touch panel connected to it still works
perfectly running LXDE on top of the modesetting X driver.
Unfortunately the 4.6.0-rc4-next-20160420 I used for testing is broken
beyond easy quick repair on i.MX 6 so I was unable to validate it on
there, sorry.


Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
