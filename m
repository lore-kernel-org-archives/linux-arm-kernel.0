From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 19 Mar 2013 11:12:53 +0200
Subject: OMAP baseline test results for v3.9-rc3
In-Reply-To: <51482707.6020501@ti.com>
References: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>
 <51482707.6020501@ti.com>
Message-ID: <1363684373.15426.137.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-03-19 at 14:21 +0530, Santosh Shilimkar wrote:
> + Tero,
> 
> On Monday 18 March 2013 09:08 PM, Paul Walmsley wrote:
> > 
> > Here are some basic OMAP test results for Linux v3.9-rc3.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.9-rc3/20130314094808/
> > 
> > 
> > Test summary
> > ------------
> > 
> Thanks for the summary Paul. A usual, it is quite exhaustive. Few
> questions and comments below.
> 
> [..]
> 
> > Failing tests: needing investigation
> > ------------------------------------
> > 
> 
> [..]
> 
> > PM tests:
> > 
> [..]
> 
> > 
> > * 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE
> > 
> I thought we discussed about boot-loader dependency already. 
> 
> > * 4460pandaes: pwrdm state mismatch on IVAHD, TESLA 
> > 
> Same here.
> 
> > * 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
> >   - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
> >     per discussion with Tero Kristo
> >   - Likely dependent on the bootloader version
> >     - fails with 2012.07-00136-g755de79
> > 
> Do you still see the issue after upgrading the boot-loader version ?

I think you should definitely upgrade your bootloader, the old one you
are using is prone to cause trouble due to bugs it has, and we have no
simple way to workaround the issues it causes on kernel side.

-Tero
