From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 12 Apr 2018 17:50:52 +0530
Subject: [PATCH v7 3/9] pinctrl: actions: Add Actions S900 pinctrl driver
In-Reply-To: <94aceb15-63a5-44a3-d0bc-f56adebc27d5@suse.de>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
 <20180404172258.7678-4-manivannan.sadhasivam@linaro.org>
 <CACRpkdZPOSDenSORGVLPuJKPP_iE97mZLXHJLcF2kH5wKPw=tg@mail.gmail.com>
 <94aceb15-63a5-44a3-d0bc-f56adebc27d5@suse.de>
Message-ID: <20180412122052.wohzjmj27c3hi3vp@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Thu, Apr 12, 2018 at 02:10:28PM +0200, Andreas F?rber wrote:
> Am 12.04.2018 um 11:04 schrieb Linus Walleij:
> > On Wed, Apr 4, 2018 at 7:22 PM, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > 
> >> Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> >> pinctrl, pinmux and pinconf functionalities through a range of registers
> >> common to both gpio driver and pinctrl driver.
> >>
> >> Pinmux functionality is available only for the pin groups while the
> >> pinconf functionality is available for both pin groups and individual
> >> pins.
> >>
> >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Patch applied for v4.18
> > 
> > GOOD WORK!
> > 
> > We really need to get this in so that Andreas can work on S500
> > patches with this as a base.
> 
> No, I refused to do that. If his patches get merged, Mani offered that
> he will take care of rebasing/rewriting S500 part.
>

Yes, if you don't have time then I can take this. Since you have already
sorted out the pin definitions, it will be much easier.
 
> > 
> > If any review comments still remain they can surely be addressed
> > with incremental improvement patches.
> 
> My biggest problem was/is that Mani designed his structs totally
> different from mine, with no explanation why or how they correlate.
> 

Agree. But we both worked orthogonally and please let me know if you
find anything wrong with my approach.

> Also I had protested against him defining fake pins for the drive
> strength. Since I did not have time to review the newer patches yet,
> please make sure that this is addressed _before_ merging. Changing the
> binding after the fact is a problem!
> 

What do you mean by fake pins for drive strength? All the pins are named
after the group name given in the datasheet. And I have already mentioned
in the binding that we can only do group access for these pins. There is
_no_way_ you can individually configure drive strength for the pins, if you
do then the entire group will get configured, does this makes sense?

Thanks,
Mani 

> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
