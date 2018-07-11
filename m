From: clabbe@baylibre.com (LABBE Corentin)
Date: Wed, 11 Jul 2018 20:59:18 +0200
Subject: [PATCH v2 0/4] sun8i: r40: add AHCI
In-Reply-To: <20180710122922.6sgmgfislqwhn3tt@flea>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
 <20180710122922.6sgmgfislqwhn3tt@flea>
Message-ID: <20180711185918.GA1152@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 02:29:22PM +0200, Maxime Ripard wrote:
> On Mon, Jul 09, 2018 at 03:20:54PM +0000, Corentin Labbe wrote:
> > Hello
> > 
> > With Moeicenowy's agreement, I have take leadership ot this patchset.
> > 
> > There are no really changes appart renaming struct quirck to variant.
> > 
> > Since the last serie is really old, I will answer comment here.
> > The two regulator (1.2 and 2.5V) are not for the PHY since:
> > - nothing in the schematic said that they are for the PHY, they seems
> >   only for controller
> > - all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
> >   cannot be used for target)
> 
> That's a pretty bad thing to do, especially for old series. You just
> dropped all the context that you reply to, and there's no way for any
> reviewer to tell if your answers make any kind of sense, or addresses
> any question one might have had.
> 

I apologize, i feared to hack a mail with the messageid.
Next time I will

> > Furthermore, the AHCI binding support only one regulator per PHY, so
> > using the "target" regulator is out of question for registring this two
> > non-phy regulator.
> 
> Nothing is "out of question", we have the source code and can change
> it if needed.
> 

Ok, I will try with a generic AHCI platform solution.

Regards
