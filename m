From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Mar 2016 12:00:49 -0700
Subject: [PATCH 04/12] ARM: dts: dragonboard-600c: add board support with
 serial
In-Reply-To: <CAP71WjwPqQn-CYtgvRZp8+wq7zPpJ=4Ao+OjUCFiN4Tz35fPXg@mail.gmail.com>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762442-9492-1-git-send-email-srinivas.kandagatla@linaro.org>
 <56F2F78E.8050002@codeaurora.org> <56F2FCD0.1000708@linaro.org>
 <CAOCOHw7TyzDf4jvAMChOFFEgsL4Z1+CcESLOuckT=Q7W9hQvCw@mail.gmail.com>
 <56F3477E.8090205@codeaurora.org>
 <CAP71WjwPqQn-CYtgvRZp8+wq7zPpJ=4Ao+OjUCFiN4Tz35fPXg@mail.gmail.com>
Message-ID: <20160329190049.GG18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24, Nicolas Dechesne wrote:
> On Thu, Mar 24, 2016 at 2:48 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > I don't make up the names, but for other qcom sbc products the
> > bootloader is looking for sbc there to make sure it picks the right dtb
> > blob. So I guess this is _the_ qcom 8064 sbc? Definitely not _the_ 8064
> > sbc though.
> >
> > If this device won't get those bootloaders that look for this then it
> > doesn't really matter and I don't care what this is named. Please take a
> > look at Documentation/devicetree/bindings/arm/qcom.txt for what I'm
> > talking about though.
> 
> 
> I would really want to get rid of the 'i need to append the DTB' on
> this board. the DT support in the bootloader have been backported , I
> am really hoping we can use this DT aware LK, and thus rely on the
> compatible string, like we do on db410c. So this is important to get
> the name/property right, since we will get there. In fact, I am even
> hoping that once we publish this DT aware LK along with this board,
> the other myriad of 8064 based 'SBC' from various vendors will upgrade
> their bootloader, so that we can have a single 'boot' image (generated
> with the help of dtbTool) that works across all devices.

Ok, I'm not sure how that's going to work though. If all these
'SBC' devices are using the same bootloader and that bootloader
is looking into SMEM for the different device identifying
attributes (called socinfo in the downstream kernel) we're going
to need to make sure that the devices identify uniquely.

There is the 'subtype' attribute, which is just a number to
identify different variations of a similar board. I hope that all
the 'SBC' boards are using different subtypes or things are going
to start getting messy.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
