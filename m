From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 28 Aug 2009 12:27:14 +0900
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <20090827131405.GB12506@sirena.org.uk>
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
	<20090827131405.GB12506@sirena.org.uk>
Message-ID: <20090828032714.GG3928@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Jin-Sung and others,

On Thu, Aug 27, 2009 at 02:14:05PM +0100, Mark Brown wrote:

> > We hope and need to discuss our ideas more and more, continuously, so
> > tell us your opinions and something like this freely about this and,
> > because s3c6410 supports is already in the mainline, we should handle
> > this SoC specially.
> 
> It would seem to be much better to integrate your work with the existing
> support for your CPUs rather than starting from scratch - there's an
> awful lot of continuity in the IPs and it'd seem strange to ignore that.
> What are the factors that are pushing you towards starting from scratch?

Nobody is proposing to start from scratch, don't worry.  Right now the plan
is as follows:

1) compare samsungs latest (2.6.28 based) 6410 support and the mainline 6410
   support and determine missing bits (if any).  Submit those missing bits

2) compare driver support for 6410 in samsungs 2.6.28 based tree and current
   mainline.  Go over each driver, determine if
   a) mainline has no driver and samsungs driver will get polished+submitted
   b) mainline has a different version of the same driver. if there are missing
      features, submit them on top of what mainline has
   c) mainline ha a completely different driver.  Decide what to do on case-by-
      case basis.

In parallel to 1+2, we want to discuss and refine an actual structure for
future SoC's.  Once that is done,

3) work on migrating samsungs existing s5p6440, s5pc100, s5pc110 code to
   conform to the new naming/structure, regularly post this for review

4) eventually submit that code mainline, keeping <= 6410 as-is or only
   with minimal modifications.

5) work on the various existing and new device drivers, gradually submit
   them to the respective subsystem maintainers.

> 
> > Finally, we should talk with Ben Dooks who is a maintainer of s3c24xx
> > series, so hope Ben's reply especially :)
> 
> You probably want to CC him on messages like this - I've added him here.

I've already sent him a mail about a week ago about what's happening at Samsung
at the moment, so he should be generally aware.  But yes, explicit Cc is
still not a bad idea.

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
