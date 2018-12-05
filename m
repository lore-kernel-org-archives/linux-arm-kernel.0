Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:26:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A1A205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+90l5f4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mnmVecL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A1A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:MIME-version:
	Date:Message-id:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aK9WD8BdEC/91OMGbp9Bsa5T5h7IXVdl+wrjH1LNWvY=; b=h+90l5f4WuWF91
	Vhya5/D8OXT98+5Ao7ZygNnjYCGuiMAMwfJvArnES+WLKDHTAhgg5XM1LZ16yoHnRMRQKCHrmMhst
	pyKGtXaE9vJQMEXJcx9M6Mbd/kICL+33/3L2RP1nsJt4MZg/Gwb+R9DoIMP7BmxrKV1mont6AIWf7
	BtudyYvegevZsfIUS6c+lpYWPChMPxcFdBdRPC4YKcQ1KYDnav3XvI0zpP84i3nprtP/mhc0NVt0u
	IgZiT81ZUpxF5saLDa2bIsCjZ19zh3zqzNh+NNT74yZVZIusqK2tKTo7D6hSOFpFF0nlwL2+AjFkg
	pr6f4o36WjU3sWqkXrIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUawY-00067G-7J; Wed, 05 Dec 2018 17:26:38 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUavm-0005FU-53
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:26:02 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20181205172536epoutp023019b1ddb06e28da09dcb2ae0bd44272~tf8YceNZG1730517305epoutp02n;
 Wed,  5 Dec 2018 17:25:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20181205172536epoutp023019b1ddb06e28da09dcb2ae0bd44272~tf8YceNZG1730517305epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544030736;
 bh=UHUosq1mTXHJMStpKnsg7BM1gxNFnfqGAcMNVPTD51Y=;
 h=Subject:To:Cc:From:Date:In-reply-to:References:From;
 b=mnmVecL9SyITQX7x/MnYI0v4UAHui/HAbywGYpUn0MZkXTNq1NNgcvYs0TLmfaxgL
 2WvuGo1migTUlOpuc8uMx7WWEzF7/vYa2NvRmaf8JkCbVqOjS3CVPbyLE/HTCg+Oet
 36O+Gd83TdoYQkvGM3qSyPyhwedzaeY6eSwV8ByM=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181205172535epcas1p1ccb867f8519fb0b2e5132a94dc73efdb~tf8Xmr5bW1646716467epcas1p1G;
 Wed,  5 Dec 2018 17:25:35 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 9F.99.04058.F0A080C5; Thu,  6 Dec 2018 02:25:35 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20181205172534epcas1p4af10af4c5d6208aa64c5f52874559486~tf8XVSmfN0431704317epcas1p4V;
 Wed,  5 Dec 2018 17:25:34 +0000 (GMT)
X-AuditID: b6c32a35-e1fff70000000fda-ec-5c080a0f3142
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
 (Symantec Messaging Gateway) with SMTP id 49.10.03601.E0A080C5; Thu,  6 Dec
 2018 02:25:34 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ9000SEXQI8A40@mmp2.samsung.com>; Thu, 06 Dec 2018 02:25:34 +0900 (KST)
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
To: Stephen Boyd <sboyd@kernel.org>, k.konieczny@partner.samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <1952090c-5454-5802-23b1-0f8d618948ec@samsung.com>
Date: Wed, 05 Dec 2018 18:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-version: 1.0
In-reply-to: <154402608077.88331.684195407604647728@swboyd.mtv.corp.google.com>
Content-language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7bCmgS4/F0eMwcJdnBbXvzxntZh/5Byr
 Rd++/4wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PF0usXmSxa9x5ht/h3bSOLA7fHmnlr
 GD02repk89i8pN7j4Ls9TB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVMXHlZqaC6UIVy5uK
 Gxh/8HYxcnJICJhIfLq7nKmLkYtDSGAHo0Tfuh3MEM53RolzKy+wwVSd7HrADmILCWxglHh1
 WwGi6D6jxIlnL5lAEsICrhILtp1jBbFFBFwkji2YBjaJWeAAk8S89SsZQRJsAoYSvUf7wGxe
 ATuJY2fPAdkcHCwCqhIr9suDhEUFIiQ67q9mgygRlPgx+R4LiM0p4C9x8X0XWCuzgKbEiy+T
 WCBscYlj929CxeUlNq95ywxx9Gc2iYdfYyFsF4ndM/eyQtjCEq+Ob2EHWSshIC1x6agtRLha
 Ytf2brCTJQQ6GCVaLmyHmmMtcfj4RVaI+XwS7772sEL08kp0tAlBlHhIfJrRyQoJk8nMEstm
 fGecwCg7C8kLs5CcPQvJ2bOQnL2AkWUVo1hqQXFuemqxYYGhXnFibnFpXrpecn7uJkZwotEy
 3cE45ZzPIUYBDkYlHt4XD9hjhFgTy4orcw8xSnAwK4nwrrABCvGmJFZWpRblxxeV5qQWH2KU
 5mBREud9IjU3WkggPbEkNTs1tSC1CCbLxMEp1cAYs7E2TeFN/Dbnyfdy516LF73BzXHuZEzp
 VkXvqKl2/O5GmkZKlzffKWgRm7dvduN6i5ZFLpIm/HN9znF+7PtXePPZHI6nwSbZd0RNety+
 mun+i5+uf3qCy/3ji7JcHPYc0JwmVHTpzIL5B1LT6nfN0ZpeZBJitCfnzd0l1q/Cyq44m07t
 Nq1UYinOSDTUYi4qTgQAjiFZGjADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e+xoC4fF0eMwefDphbXvzxntZh/5Byr
 Rd++/4wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PF0usXmSxa9x5ht/h3bSOLA7fHmnlr
 GD02repk89i8pN7j4Ls9TB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVMXHlZqaC6UIVy5uK
 Gxh/8HYxcnJICJhInOx6wN7FyMUhJLCOUaJp50Uo5yGjxIb9H5hBqoQFXCUWbDvHCmKLCLhI
 HFswjRmkiFngAJPE9M9XoDomM0usnrucBaSKTcBQovdoHyOIzStgJ3Hs7Dkgm4ODRUBVYsV+
 eZCwqECExNmX66BKBCV+TL4H1sop4C9x8X0XWDmzgLrElCm5IGFmAXGJY/dvMkLY8hKb17xl
 nsAoMAtJ9yyEjllIOmYh6VjAyLKKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93EyMwZrYd
 1urbwXh/SfwhRgEORiUe3hcP2GOEWBPLiitzDzFKcDArifCusAEK8aYkVlalFuXHF5XmpBYf
 YpTmYFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwLhcQc599fPZR/IfzLQQWbZk5cqV6/yS
 LnNzTyk4JNIzM+P1koqq899nW+zb8rC/IGDqZHeprR9/dyctu3eGT/LdyQssXGe7g1xD3yve
 uxZ50Yfv96U320QN8psUEnKrFU+9txc1Dm/dnxP6yD1x5marC7pVOg8fK0SkCAr7bzU6HPTo
 sJiXjYsSS3FGoqEWc1FxIgB3+Gw3lQIAAA==
X-CMS-MailID: 20181205172534epcas1p4af10af4c5d6208aa64c5f52874559486
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
 <20181204165248.17572-6-k.konieczny@partner.samsung.com>
 <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
 <3bb9f4b5-e069-79fe-6ab3-2750c6191e57@samsung.com>
 <154402608077.88331.684195407604647728@swboyd.mtv.corp.google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_092550_758787_F1840BFB 
X-CRM114-Status: GOOD (  21.08  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/5/18 17:08, Stephen Boyd wrote:
> Quoting Sylwester Nawrocki (2018-12-05 02:57:32)
>> On 12/4/18 19:40, Stephen Boyd wrote:
>>> Quoting Kamil Konieczny (2018-12-04 08:52:48)
>>>> +
>>>> +static const unsigned long imem_clk_regs[] __initconst = {
[...]
>>>> +};
>>>> +
>>>> +static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
>>>> +       /* ENABLE_ACLK_IMEM */
>>>> +       GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_200",
>>>> +                       ENABLE_ACLK_IMEM, 24, 0, 0),
>>
>> I don't think that clock will ever need to be disabled/enabled, so I would
>> drop this definition. The clock will remain in its default state after reset
>> (enabled).
>>
>>>> +       GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
>>>> +                       ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),
>>>
>>> Why is there so much use of CLK_IGNORE_UNUSED in this file?
>>
>> I suppose CLK_IGNORE_UNUSED is needed because there is no drivers that
>> would enable required clocks. For some clocks the flag could probably
>> indeed just be omitted, e.g. SLIMSSS clocks. 
>>
>> I'm inclined to just define clocks that we are confident about and which
>> are needed now. i.e. the SSS IP block clocks. So in include/dt-bindings/
>> clock/exynos5433.h we would have something like:
> 
> Agreed, it doesn't make much sense to add clk support for clks that
> you'll never need to modify one way or the other.
> 
>>  
>> +/* CMU_IMEM */
>> +#define CLK_ACLK_SSS                   1
>> +#define CLK_PCLK_SSS                   40
>>
>> +#define IMEM_NR_CLK                    41
>>
>> The other clocks could be added later as needed by someone who has 
>> detailed knowledge about respective peripheral blocks.
>>
> 
> The slow addition of new clks to the binding header file makes for an
> integration problem, so can we try to expose any clks that we know about
> now as defines and make them not work if the driver isn't implementing
> support for those clks? That way the binding is not changing but the
> implementation can decide to support or not support certain clks.

That makes a lot of sense to me. Then all we have to do now is to drop
some of the entries in the imem_gate_clks array above.

-- 
Regards,
Sylwester

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
