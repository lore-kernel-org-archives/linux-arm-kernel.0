From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 29 Mar 2016 07:21:10 -0700
Subject: [PATCH 04/12] ARM: dts: dragonboard-600c: add board support with
 serial
In-Reply-To: <56F3477E.8090205@codeaurora.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762442-9492-1-git-send-email-srinivas.kandagatla@linaro.org>
 <56F2F78E.8050002@codeaurora.org> <56F2FCD0.1000708@linaro.org>
 <CAOCOHw7TyzDf4jvAMChOFFEgsL4Z1+CcESLOuckT=Q7W9hQvCw@mail.gmail.com>
 <56F3477E.8090205@codeaurora.org>
Message-ID: <20160329142110.GE8929@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23 Mar 18:48 PDT 2016, Stephen Boyd wrote:

> On 03/23/2016 06:04 PM, Bjorn Andersson wrote:
> > On Wed, Mar 23, 2016 at 1:30 PM, Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >> On 23/03/16 20:07, Stephen Boyd wrote:
[..]
> >
> > Also, if I make a product based of this board, with some minor
> > changes, is that still the sbc?
> >
> > I think the compatible should be "qcom,apq8064-db600c",
> > "qcom,apq8064-sbc", "qcom,apq8064"
> >
> >
> 
> I really hope that people don't keep using the qcom bootloader dtb
> picking design if they make a new product based off qcom boards with a
> slight variation. They should replace the vendor part of the compatible
> anyway with their own vendor prefix, and then the bootloader would need
> to be updated to look for that string or something else. I really don't
> want to get in the business of updating dtbTool for all the non-qcom
> designs that pop up because they keep using the qcom dtb identification
> scheme. It almost doesn't scale right now and that's just qcom designs.

At that other company the various dtb's that was to be picked for a
given product was always to support the various SoC versions; so those
devices always shipped with the mtp board-id and msm-id.

As far as I've seen this is how Qualcomm's Android customers does it.


But as things progress further I do see a need for being able to also
pick the right product and at that point you're right that the vendor
must change their boot loader.

Regards,
Bjorn
