From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 13 Jul 2016 17:10:28 +0800
Subject: [PATCH V2 07/15] doc: dt: fsl-imx-esdhc: add set tuning start
 point binding
In-Reply-To: <20160712135907.GA30437@lunn.ch>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <1468309584-3591-8-git-send-email-aisheng.dong@nxp.com>
 <20160712135907.GA30437@lunn.ch>
Message-ID: <20160713091028.GB27041@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Jul 12, 2016 at 03:59:07PM +0200, Andrew Lunn wrote:
> On Tue, Jul 12, 2016 at 03:46:16PM +0800, Dong Aisheng wrote:
> > add tuning start point binding
> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > index dca56d6248f5..3e29050ec769 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > @@ -28,6 +28,8 @@ Optional properties:
> >    transparent level shifters on the outputs of the controller. Two cells are
> >    required, first cell specifies minimum slot voltage (mV), second cell
> >    specifies maximum slot voltage (mV). Several ranges could be specified.
> > +- fsl,tuning-start-tap: Specify the start dealy cell point when send first CMD19
> > +  in tuning procedure.
> >  - fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
> >    The uSDHC use one delay cell as default increasing step to do tuning process.
> >    This property allows user to change the tuning step to more than one delay
> 
> Hi Dong
> 
> You say this is a patch which should be part of stable. How does it
> fulfil the requirements listed in
> 
> Linux/Documentation/stable_kernel_rules.txt
> 

Sorry i'm not so familiar with stable rules before the posting.

This patch is mainly to separate the binding doc changes from the driver
changes in patch 6.

Why we need add the tuning-start-tap is because we met some tuning problem
on boards like MX7D SDB RevC, the board timing slight difference may
cause the default tuning steps(2 cells) can't cover the required tuning
range, then tuning fail.

This patch allow users to bypass the first a few meaningless tuning ranges
if they meet the problem.

Since there's no users in tree currently, i'm not sure if it breaks the rule.
But indeed people may need it if they meet this problem.

Regards
Dong Aisheng

> Thanks
> 	Andrew
