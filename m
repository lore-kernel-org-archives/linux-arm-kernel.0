From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 11 Jan 2011 10:25:20 +0200
Subject: [PATCH 0/2] ARM i.MX53 enable SMD and LOCO board bootup
In-Reply-To: <AANLkTikhf7ReDZRt+CRuzupD_oQb7LMfTDa2fvpjayRB@mail.gmail.com>
References: <1294726998-20830-1-git-send-email-yong.shen@freescale.com>
	<20110111072301.GA19168@jasper.tkos.co.il>
	<AANLkTikhf7ReDZRt+CRuzupD_oQb7LMfTDa2fvpjayRB@mail.gmail.com>
Message-ID: <20110111082520.GB22418@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Tue, Jan 11, 2011 at 03:54:43PM +0800, Yong Shen wrote:
> So far they are similar, but as more code and features are added in,
> they are going to be different. We had registered different mach id to
> distinguish these two boards.

Code for two (or more) different machines can be shared in the same file. See 
for example the code in arch/arm/mach-at91/board-stamp9g20.c which supports 
both taskit PortuxG20 and taskit Stamp9G20, and 
arch/arm/mach-at91/board-pcontrol-g20.c which is reusing code from these 
boards for a third board (PControl G20).

We should avoid code duplication as much as possible, IMO.

baruch

> On Tue, Jan 11, 2011 at 3:23 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> > On Tue, Jan 11, 2011 at 02:23:16PM +0800, yong.shen at freescale.com wrote:
> >> SMD and LOCO are newly developed boards of i.MX53. LOCO means "low cost",
> >> which is supposed to be widespread soon.
> >
> > These two patches seem almost identical. Can't both board support code share
> > the same file?

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
