From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 20 Dec 2012 08:00:49 +1300
Subject: Inconsistency in clk framework
In-Reply-To: <1355938492.27893.8.camel@gitbox>
References: <1355890233.25599.4.camel@gitbox>
 <20121219092636.GW14363@n2100.arm.linux.org.uk>
 <1355938492.27893.8.camel@gitbox>
Message-ID: <1355943649.2451.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-12-20 at 06:34 +1300, Tony Prisk wrote:
> On Wed, 2012-12-19 at 09:26 +0000, Russell King - ARM Linux wrote:
> > On Wed, Dec 19, 2012 at 05:10:33PM +1300, Tony Prisk wrote:
> > > Hi Mike,
> > > 
> > > In attempting to remove some IS_ERR_OR_NULL references, it was pointed
> > > out that clk_get() can return NULL if CONFIG_HAVE_CLK is not defined.
> > 
> > That is correct - but why is that a problem?  As far as users are
> > concerned, NULL is a valid clock.  If HAVE_CLK is undefined, do you
> > want all your drivers to suddenly stop working?
> 
> That will be where the misunderstanding has occurred - I didn't consider
> NULL to be a valid clock.
> 
> Given that NULL is a valid clock, I guess all tests against get_clk and
> of_get_clk results should be IS_ERR_OR_NULL. Correct?
> 
For the sake of clarity, I should rephrase:

If the driver can't operate with a NULL clk, it should use a
IS_ERR_OR_NULL test to test for failure, rather than IS_ERR.

Regards
Tony P
