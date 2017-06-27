From: leoyang.li@nxp.com (Leo Li)
Date: Tue, 27 Jun 2017 16:38:00 +0000
Subject: [v3] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck hacking
 jiffies.
In-Reply-To: <20170625024638.t6awgp7omzq5dcnk@home.buserror.net>
References: <1493963118-11064-1-git-send-email-karim.eshapa@gmail.com>
 <20170625024638.t6awgp7omzq5dcnk@home.buserror.net>
Message-ID: <AM4PR0401MB1699F4CD65C50361933D2FA48FDC0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Scott Wood [mailto:oss at buserror.net]
> Sent: Saturday, June 24, 2017 9:47 PM
> To: Karim Eshapa <karim.eshapa@gmail.com>
> Cc: Roy Pledge <roy.pledge@nxp.com>; linux-kernel at vger.kernel.org;
> Claudiu Manoil <claudiu.manoil@nxp.com>; colin.king at canonical.com;
> linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; Leo Li
> <leoyang.li@nxp.com>
> Subject: Re: [v3] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
> hacking jiffies.
> 
> On Fri, May 05, 2017 at 07:45:18AM +0200, Karim Eshapa wrote:
> > Use msleep() instead of stucking with
> > long delay will be more efficient.
> >
> > Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> > ---
> >  drivers/soc/fsl/qbman/qman.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> Acked-by: Scott Wood <oss@buserror.net>
> 
> (though the subject line should be "soc/qman: ...")
> 
> Leo, are you going to send this patch (and other qman patches) via arm-soc?

Yes.  I can take it through the pull request for soc/fsl via arm-soc.  As mentioned in the feedback from David in another email, probably we should update the comment and commit message to mention how 10000 cycles becomes 1ms.

Regards,
Leo
