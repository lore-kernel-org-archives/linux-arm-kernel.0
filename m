From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 13 Mar 2012 11:28:07 -0600
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <4F5F60DB.9090801@itwatchdogs.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <4F5F5B3F.2000303@gmail.com> <4F5F60DB.9090801@itwatchdogs.com>
Message-ID: <20120313172807.AC4763E053B@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Mar 2012 09:59:39 -0500, Zach Sadecki <zsadecki@itwatchdogs.com> wrote:
> On 03/13/2012 09:35 AM, Rob Herring wrote:
> > +	ahb at 80080000 {
> > +		fec at 800f0000 {
> > Use generic names: ethernet at 800f0000
> Generic is good, but consistency is better, IMHO.  grepping existing dts 
> files in 3.2.9 finds 6 instances of "fec@" and 0 instances of "ethernet@"
> >> +			uart1: uart at 80074000 {
> > Use generic names: uart1: serial at ...
> Same comment here, but unfortunately there is already inconsistency in 
> existing files...  25 instances of "serial@" and 35 instances of "uart@"

No, Rob is correct.  The generic names recommended practice is well
established and documented.  Expand your grep search to include
arch/powerpc/bot/dts/*.

See section 2.2.2 of ePAPR[1]

[1]https://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.1.pdf

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
