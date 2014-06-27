From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Fri, 27 Jun 2014 20:19:26 +0900
Subject: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
In-Reply-To: <CAD=FV=VP6Exg-iJiAk=zNFpFzY8jFbU8HSR=wQQ7S+mfZWTJ=Q@mail.gmail.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
 <CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
 <53AA3F78.3080804@samsung.com>
 <001201cf9067$3c5b2070$b5116150$%jun@samsung.com>
 <CAD=FV=UCinFuZQW+_GYFw=M046ziTLRNvvHUvsx_GQ0kjw5DfQ@mail.gmail.com>
 <004f01cf9129$b4ac9690$1e05c3b0$%jun@samsung.com>
 <CAD=FV=VP6Exg-iJiAk=zNFpFzY8jFbU8HSR=wQQ7S+mfZWTJ=Q@mail.gmail.com>
Message-ID: <001201cf91f9$a7924920$f6b6db60$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, June 27, 2014, Doug Anderson wrote:
> Seungwon,
> 
> On Thu, Jun 26, 2014 at 3:30 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Hi Doug,
> >
> > On Thu, June 26, 2014, Doug Anderson wrote:
> >> Seungwon,
> >>
> >> On Wed, Jun 25, 2014 at 4:18 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> >> >> +       case MMC_POWER_ON:
> >> >> >> +               if (!IS_ERR(mmc->supply.vqmmc) &&
> >> >> >> +                               !test_bit(DW_MMC_IO_POWERED, &slot->flags)) {
> >> > You can use regulator_is_enabled() instead of flag bit, DW_MMC_IO_POWERED.
> >>
> >> I'd be a little worried about regulator_is_enabled() since regulators
> >> are reference counted.  What if someone else is sharing this
> >> regulator?  The regulator might happen to be enabled when you check it
> >> but unless you add your own dw_mmc reference count they might turn it
> >> off.
> > Cool, that's a possibility. Some assumption may need.
> > If mmc's core can guarantee its balance, I think we don't need to consider some flag.
> 
> I notice that the mmc core seems to keep a flag itself for vdd (the
> mmc->regulator_enabled flag).  That would imply that the core thought
> it was important to have the extra flag and that we should keep our
> own flag for vqmmc.
Ok, Good.

Thanks,
Seungwon Jeon
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
