Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:48:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEE92070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iXotjmON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEE92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:Date:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CmCN2R2mC9dn3qgG/JKIGdHrPy0sryKqSRXGySFBAxU=; b=iXotjmONjydSP62a3wArbya4Y
	yXJc1W90ybkXWV1QSgJWh5MdmwoMi764q0xifmO7O5ZFEQqt+HHP1iJfryzST4Iu7fuqeeX9puRNT
	SVZR3WlaUnoV/age6ObSOY/vNrvtTIHZS7j1hWz4d/G1gOjxv59WRUsUrkltpr+8shdtqlMuC2Eyk
	mpf090ccsjZJMdYkGozu80/rp+raSHSJMNE/seJwuFi38CSDtXsKull95AdTqS71GoDUSP1PFExy3
	uBh47jGhvRslE1SeXD6VtSjAHi90spk698pEGjhwN/254kojhUwULCIc9TAkGyZ66ZTIEr9xyaCzL
	IcfLX/+iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXphK-0000cX-7q; Fri, 14 Dec 2018 15:48:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXphG-0000Ys-R7
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:48:16 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBEFhlCo125992
 for <linux-arm-kernel@lists.infradead.org>; Fri, 14 Dec 2018 10:48:01 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pcenx2gru-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 14 Dec 2018 10:48:00 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <eajames@linux.ibm.com>;
 Fri, 14 Dec 2018 15:47:59 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Dec 2018 15:47:55 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBEFlsKB23331052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Dec 2018 15:47:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64DB0B2066;
 Fri, 14 Dec 2018 15:47:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C49E9B2065;
 Fri, 14 Dec 2018 15:47:53 +0000 (GMT)
Received: from oc6728276242.ibm.com (unknown [9.85.180.238])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 14 Dec 2018 15:47:53 +0000 (GMT)
Subject: Re: [PATCH 2/2] clk: aspeed: Setup video engine clocking
To: Joel Stanley <joel@jms.id.au>
References: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com>
 <1544559161-21468-3-git-send-email-eajames@linux.ibm.com>
 <CACPK8XcY_c9NzNv-WyZcz+mZ5c2jixyCzEQAK-+t0QvQ_uJXwg@mail.gmail.com>
From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 14 Dec 2018 09:47:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACPK8XcY_c9NzNv-WyZcz+mZ5c2jixyCzEQAK-+t0QvQ_uJXwg@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18121415-0064-0000-0000-0000038668E7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010224; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131703; UDB=6.00588165; IPR=6.00911835; 
 MB=3.00024690; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 15:47:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121415-0065-0000-0000-00003BADFF45
Message-Id: <81b100b7-252e-3145-fb34-17a9c0cdd91e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_074814_984302_6C30BE00 
X-CRM114-Status: GOOD (  35.14  )
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
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 Michael Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/13/2018 07:02 PM, Joel Stanley wrote:
> Hi Eddie,
>
> On Wed, 12 Dec 2018 at 06:42, Eddie James <eajames@linux.ibm.com> wrote:
>> Add the video engine reset bit. Add eclk mux and clock divider table.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Acked-by: Stephen Boyd <sboyd@kernel.org>
>> ---
>>   drivers/clk/clk-aspeed.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
>> index 5961367..f16ce7d 100644
>> --- a/drivers/clk/clk-aspeed.c
>> +++ b/drivers/clk/clk-aspeed.c
>> @@ -87,7 +87,7 @@ struct aspeed_clk_gate {
>>   /* TODO: ask Aspeed about the actual parent data */
>>   static const struct aspeed_gate_data aspeed_gates[] = {
>>          /*                               clk rst   name                 parent  flags */
>> -       [ASPEED_CLK_GATE_ECLK] =        {  0, -1, "eclk-gate",          "eclk", 0 }, /* Video Engine */
>> +       [ASPEED_CLK_GATE_ECLK] =        {  0,  6, "eclk-gate",          "eclk", 0 }, /* Video Engine */
>
>>          [ASPEED_CLK_GATE_GCLK] =        {  1,  7, "gclk-gate",          NULL,   0 }, /* 2D engine */
>>          [ASPEED_CLK_GATE_MCLK] =        {  2, -1, "mclk-gate",          "mpll", CLK_IS_CRITICAL }, /* SDRAM */
>>          [ASPEED_CLK_GATE_VCLK] =        {  3,  6, "vclk-gate",          NULL,   0 }, /* Video Capture */
>> @@ -113,6 +113,24 @@ struct aspeed_clk_gate {
>>          [ASPEED_CLK_GATE_LHCCLK] =      { 28, -1, "lhclk-gate",         "lhclk", 0 }, /* LPC master/LPC+ */
>>   };
>>
>> +static const char * const eclk_parent_names[] = {
>> +       "mpll",
> Is the mpll really an input to the eclk?

Yep, it's the default.

>
>> +       "hpll",
>> +       "dpll",
> We don't have a dpll in the driver that I can see.

True... I supposed I would just add the parent here now in case the dpll 
clock is ever added.

>
>> +};
>> +
>> +static const struct clk_div_table ast2500_eclk_div_table[] = {
> Is the clocking setup different on the ast2400?

Yes, the dividers are the default ast2400 ones.

>
>> +       { 0x0, 2 },
>> +       { 0x1, 2 },
>> +       { 0x2, 3 },
>> +       { 0x3, 4 },
>> +       { 0x4, 5 },
>> +       { 0x5, 6 },
>> +       { 0x6, 7 },
>> +       { 0x7, 8 },
>> +       { 0 }
>> +};
>> @@ -317,6 +338,7 @@ struct aspeed_reset {
>>          [ASPEED_RESET_PECI]     = 10,
>>          [ASPEED_RESET_I2C]      =  2,
>>          [ASPEED_RESET_AHB]      =  1,
>> +       [ASPEED_RESET_VIDEO]    =  6,
> You've added the reset line to the ASPEED_CLK_GATE_ECLK clock so you
> do not need to separately expose the reset controller. Instead
> enabling the clock will deassert the rest line for you.
>
> This means you should drop the change from the header too, and it
> affects the bindings document for the video engine.

I want that reset available separately for use in the video engine 
actually. I could do without it, but it's somewhat useful.

Thanks,
Eddie

>
>>          /*
>>           * SCUD4 resets start at an offset to separate them from
>> @@ -522,6 +544,22 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>>                  return PTR_ERR(hw);
>>          aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
>>
>> +       hw = clk_hw_register_mux(dev, "eclk-mux", eclk_parent_names,
>> +                                ARRAY_SIZE(eclk_parent_names), 0,
>> +                                scu_base + ASPEED_CLK_SELECTION, 2, 0x3, 0,
>> +                                &aspeed_clk_lock);
>> +       if (IS_ERR(hw))
>> +               return PTR_ERR(hw);
>> +       aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
>> +
>> +       hw = clk_hw_register_divider_table(dev, "eclk", "eclk-mux", 0,
>> +                                          scu_base + ASPEED_CLK_SELECTION, 28,
>> +                                          3, 0, soc_data->eclk_div_table,
>> +                                          &aspeed_clk_lock);
>> +       if (IS_ERR(hw))
>> +               return PTR_ERR(hw);
>> +       aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
>> +
>>          /*
>>           * TODO: There are a number of clocks that not included in this driver
>>           * as more information is required:
>> @@ -531,7 +569,6 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>>           *   RGMII
>>           *   RMII
>>           *   UART[1..5] clock source mux
>> -        *   Video Engine (ECLK) mux and clock divider
>>           */
>>
>>          for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
>> --
>> 1.8.3.1
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
