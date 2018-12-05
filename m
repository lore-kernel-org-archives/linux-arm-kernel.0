Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C260C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:04:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B69A2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OyVQ+StT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKMqhmjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B69A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fHh+4kVdF4BVHR6QXgJMn1URKk9TIffWx7PPq4pAIag=; b=OyVQ+StTZ4Vsre
	lGny3LufP3o+nzTb9w5tMrXVDgB35W1StWFLDrZMYOi2PCC7Apv9kF/NnjGYvoKouZzijhOf1wrJ1
	l5A+kcXbIyLTuZxKsuebbtbtqT8UMJwviLt84hJIGnj+7BMx8tMEaAh6fVT+ndqayQIsoJoOqUh34
	eonND83mHGk55s+snZUYvzWallQqJfhiAqxXYrnfBNsfE83Wd74Ue3s9Xp/9/RgLZDfMnuOq2I362
	HFY4h6Ji3IAnQHKSXt8dt03njncjsiGxTHfmp2iAeV4UZP8odFWRKcqlcnI9QfCQHMx+ZrwdEFpeB
	ou0rK9mMpyk+nPa/7uAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeLQ-0006gL-B5; Wed, 05 Dec 2018 21:04:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeL8-0006K8-20
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 21:04:17 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 819512082B;
 Wed,  5 Dec 2018 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544043843;
 bh=yqAcIeYYGue0Jq0u+kidcitXyxVO6jskzzMVMEI7Dxo=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=hKMqhmjAX/yu7eS/wJwVEU42VXYAKD1qnPAmbrQwA/eS9h6UGD34N/ZhtRGadES3j
 HMiKslXqxOifmiyXUPTaRtP2ZQReEgIDItSJF4agY//jieesgIsDL17rcU+r4hRrxU
 tr4KhaG1RPocOhcsaVlhMzkr3LNLuE7UtuwboaKM=
MIME-Version: 1.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <05b9ee40-d51e-3f80-8ca4-217fa6fbd51c@codeaurora.org>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
 <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
 <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
 <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
 <20181205164843.GB1492@tuxbook-pro>
 <05b9ee40-d51e-3f80-8ca4-217fa6fbd51c@codeaurora.org>
Message-ID: <154404384283.88331.2522037578224950651@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
Date: Wed, 05 Dec 2018 13:04:02 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_130414_483207_3BE7EC47 
X-CRM114-Status: GOOD (  23.98  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andy Gross <andy.gross@linaro.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jeffrey Hugo (2018-12-05 09:03:54)
> On 12/5/2018 9:48 AM, Bjorn Andersson wrote:
> > On Wed 05 Dec 08:38 PST 2018, Jeffrey Hugo wrote:
> > 
> >> On 12/5/2018 9:12 AM, Marc Gonzalez wrote:
> >>> On 15/11/2018 21:44, Jeffrey Hugo wrote:
> >>>
> >>>> The root parent clock of most msm8998 clock is the "xo" clock.  The DT node
> >>>> is incorrectly named "xo_board", which prevents Linux from correctly
> >>>> parsing the clock tree, resulting in most clocks being unparented and
> >>>> unable to be manipulated.  The end result is that we can't turn on clocks
> >>>> for peripherals like SD, so init usually fails.
> >>>>
> >>>> Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
> >>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> >>>> ---
> >>>>    arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >>>> index 78227cc..a948d4b 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >>>> @@ -53,7 +53,7 @@
> >>>>            };
> >>>>            clocks {
> >>>> -          xo_board {
> >>>> +          xo {
> >>>>                            compatible = "fixed-clock";
> >>>>                            #clock-cells = <0>;
> >>>>                            clock-frequency = <19200000>;
> >>>>
> >>>
> >>> Isn't there going to be a problem for msm8998 in drivers/clk/qcom/clk-smd-rpm.c
> >>> which uses "xo_board" for parent_names?
> >>
> >> Looks like you are right.  This doesn't seem to be the correct way to
> >> address the issue then.  I'll have to dig in and take another look.
> >>
> > 
> > The appropriate solution is to describe references between clock drivers
> > explicitly in DeviceTree and by that not rely on a global namespace.
> > That will also sort out any initialization ordering issues that we might
> > have.
> > 
> > But this task has not yet made it off the todo lists where it lives...
> 
> Ok, that sounds great, but doesn't seem like it helps anyone today.
> 
> Looks like 8916 and 8974 explicitly register an xo clock off the 
> xo_board clock in the respective gcc drivers.  8996 does not, but I 
> don't know how functional 8996 really is on mainline.  845 seems to 
> register the bi_tcxo clock (the 845 version of xo) in the rpmh driver, 
> off of xo_board.
> 
> Since both Marc and I are trying to get 8998 to work, it seems like one 
> of those two solutions would be workable, short term.
> 
> How do you suggest we proceed?
> 

I don't quite understand the patch in general. The xo_board clk should
always exist in DT and the fixed factor clk in GCC is there until the
rpm clk driver can control the XO clk state vote for the kernel.

If anything, change the DT node to be named xo-board instead of xo_board
because that matches DT naming schemes and then add a clock-output-names
= "xo_board" property to it so that we keep the underscore.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
