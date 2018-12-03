Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CAEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E411C2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j01tKL41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E411C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sBKvjUnMNZ3hj0v6/V4+26kbimHfhtSWBw+4glwgo54=; b=j01tKL41JqnCWF6USW54opxRg
	7s7+15xPb1awUaPSggc+7rNCit2aC5Iu+XqJ39LP1Z+5t4sTrtcA33WGAWJgXSC21e3xyghWFS/hz
	uMhZ6LTmK+amx/PciMiTjUJc1xRbRTelAoth1Kdji5ULfHVPnJoialD5bl+yYg+JRQTIWzoHwCDCK
	/ocPzqwapql0tE9GIfeSe+Gr+git2/CmuUMFwX5gNMoNWPtGQkAGo4hJr2MlvUFgw/Ba1jBPtzyKF
	HBK6xuHbPmxQQZER51XWYE1JejsBbm7ElJQx7dNr7jkf2+pU1HZUoTgQPpB8vy6msW6ft1D3EvcT8
	QjW2nDA/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjHN-0000L5-9w; Mon, 03 Dec 2018 08:08:33 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjHH-000055-SN
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:08:31 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 03 Dec 2018 17:08:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id EB98160062;
 Mon,  3 Dec 2018 17:08:16 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Mon, 3 Dec 2018 17:08:16 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 4522940394;
 Mon,  3 Dec 2018 17:08:16 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 24EAB120455;
 Mon,  3 Dec 2018 17:08:16 +0900 (JST)
Subject: Re: [PATCH 06/14] dt-bindings: clock: milbeaut: add Milbeaut clock
 description
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-7-git-send-email-sugaya.taichi@socionext.com>
 <154356596981.88331.14415961625410424962@swboyd.mtv.corp.google.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <15178a7c-7d12-7c10-6093-192754827b5a@socionext.com>
Date: Mon, 3 Dec 2018 17:08:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154356596981.88331.14415961625410424962@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_000828_796684_282FE927 
X-CRM114-Status: GOOD (  23.42  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Thank you for your comments.

On 2018/11/30 17:19, Stephen Boyd wrote:
> Quoting Sugaya Taichi (2018-11-18 17:01:11)
>> Add DT bindings document for Milbeaut clock.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../devicetree/bindings/clock/milbeaut-clock.txt   | 93 ++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-clock.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
>> new file mode 100644
>> index 0000000..5c093c8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
>> @@ -0,0 +1,93 @@
>> +Milbeaut M10V Clock Controller Binding
>> +----------------------------------------
>> +Milbeaut clock controller is consists of few oscillators, PLL, multiplexer
>> +and few divider modules
>> +
>> +This binding uses common clock bindings
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible: shall be "socionext,milbeaut-m10v-clk-regs"
>> +- reg: shall contain base address and length of clock registers
>> +- #clock-cells: shall be 0
>> +
>> +Example:
>> +       m10v-clk-tree@ {
>> +               compatible = "socionext,milbeaut-m10v-clk-regs";
>> +               reg = <0x1d021000 0x4000>;
>> +
>> +               clocks {
>> +                       #address-cells = <0>;
>> +                       #size-cells = <0>;
>> +
>> +                       uclk40xi: uclk40xi {
>> +                               compatible = "fixed-clock";
>> +                               #clock-cells = <0>;
>> +                               clock-frequency = <40000000>;
>> +                       };
>> +               };
> 
> This style of binding is highly discouraged. We don't describe each and
> every clk in DT, we describe clk controllers and their outputs and
> inputs in DT. The driver is the place where the clock controller
> describes the internal clk topology of that controller. Also, fixed
> frequency clks are typically oscillators and those would come from the
> board dts file, but otherwise I wouldn't expect to see fixed frequency
> clks in DT.

I understand. Received the similar comment from Rob in the DT part also.

> 
>> +       }
>> +
>> +The clock consumer shall specify the desired clock-output of the clock
>> +controller (as defined in [2]) by specifying output-id in its "clock"
>> +phandle cell
>> +[2] arch/arm/boot/dts/milbeaut-m10v-clk.h
>> +
> [...]
>> +
>> +Example
>> +       piclk_mux_0: spiclk_mux_0 {
>> +               compatible = "socionext,m10v-clk-div";
>> +               #clock-cells = <0>;
>> +               clocks = <&pll10_div_1_2>;
>> +               offset = <bSPICLK>;
>> +               mask = <0x3>;
>> +               ratios = <4 0x5 2 0x4>;
>> +       };
>> +
>> +       pll10: pll10 {
>> +               compatible = "socionext,m10v-pll-fixed-factor";
>> +               #clock-cells = <0>;
>> +               clocks = <&uclk40xi>;
>> +               offset = <10>;
>> +               clock-div = <5>;
>> +               clock-mult = <108>;
>> +       };
>> +
>> +       emmcclk: emmcclk {
>> +               compatible = "socionext,m10v-clk-div";
>> +               #clock-cells = <0>;
>> +               clocks = <&pll11>;
>> +               offset = <bEMMCCLK>;
>> +               mask = <0x3>;
>> +               ratios = <15 0x7 10 0x6 9 0x5 8 0x4>;
> 
> Yeah, please no. This whole binding needs a rewrite to not have one node
> per clk.

OK, I will renew the binding.

Thanks.
Sugaya Taichi

> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
