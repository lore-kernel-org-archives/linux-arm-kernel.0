From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 25 Jan 2016 19:44:01 +0100
Subject: [PATCH V2 4/4] mfd: mediatek: add MT6323 support to MT6397 driver
In-Reply-To: <56A64108.7020807@openwrt.org>
References: <1453716887-38442-1-git-send-email-blogic@openwrt.org>
 <20160125124112.GG3368@x1> <56A64108.7020807@openwrt.org>
Message-ID: <3476571.0yU9yvPsKF@linux-gy6r.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 Jan 2016 16:36:40 John Crispin wrote:
> Hi,
> 
> On 25/01/2016 13:41, Lee Jones wrote:
> > Please honour the subject format of the subsystem you are contributing
> > to.
> > 
> > `git log --oneline -- $subsystem` gives you this.
> > 
> > On Mon, 25 Jan 2016, John Crispin wrote:
> >> Signed-off-by: John Crispin <blogic@openwrt.org>
> >> ---
> 
> [...]
> 
> >> @@ -261,6 +271,15 @@ static int mt6397_probe(struct platform_device
> >> *pdev)
> >> 
> >>  	}
> >>  	
> >>  	switch (id & 0xff) {
> >> 
> >> +	case MT6323_CID_CODE:
> >> +		mt6397->int_con[0] = MT6323_INT_CON0;
> > 
> > This is confusing.  You're still using memory allocated for a mt6397
> > device.
> 
> the variable is currently defined as struct mt6397_chip *mt6397;
> shall i only change the name or also create a patch to rename the struct ?
> 

I think we should rename the struct and the file as well.

Cheers,
Matthias
