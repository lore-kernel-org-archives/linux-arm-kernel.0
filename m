Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47071C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:47:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CA0206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gGAkpAsj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H7LLt6XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CA0206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:MIME-version:
	Date:Message-id:To:Subject:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f+S0rPjOTfFvFMUqntau+mo6FlNOMx7UkfGNoALTTs4=; b=gGAkpAsjyvT4Bl
	xDJlmEP9QRwn1lThlSua+ej2IEbKAyU4Ou7HpP0VqiLFLkaZnyURDTPqtpbDtOjbO4OG2gjpgJVe5
	AyOagvyJsWq0kZEvN9lPZkYZ7/Biwtaob/VSi1veL84bumDYejQjXDUZeL05Ujsr+4NOmL3xG9kt9
	Vscdb6ZhVGhqDDENDhP5oAc3qrHVd6ekeMBnTVAo8Ze29B+81WkmZLkUY8fueGVP2GFitYMU2+BbS
	JHVx5fCvIg8zeIo+bAEqI7F+PcSFvbGVe4hPubkqrFbflxSBRitN+Ftzygv+Y4RuCJsIfTA98/ULH
	JtJTTzD2djrdpidAywYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYrNI-0005S6-4P; Mon, 17 Dec 2018 11:47:52 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrNE-0005MD-5r
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 11:47:50 +0000
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20181217114732epoutp024cd57cf04365060541115826221148f2~xHEo4_J2V1131511315epoutp02C;
 Mon, 17 Dec 2018 11:47:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20181217114732epoutp024cd57cf04365060541115826221148f2~xHEo4_J2V1131511315epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1545047252;
 bh=ncdbedac4qRKZRte3d1O0ToPR7ASDw+/zF612ndXhEg=;
 h=From:Subject:To:Cc:Date:In-reply-to:References:From;
 b=H7LLt6XNGRxrzM92v0BsMfXfkVO1oXBGLCVCsrcHsXlsaIyyyLwCMyj58uSwhsdrq
 Cp4XfwbIsswiLIUuLirYvjkui4xjldQx6V5ZdE+E2z5BHCqsFVbPJrCLmrNvpwxIeB
 GrlBBtBho1O6mcLHmUDJ5PpVf4lB52ucmGslFTg0=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20181217114731epcas2p191fdcc9250fd6194294a0841ae88d445~xHEodIp5F1769317693epcas2p1Y;
 Mon, 17 Dec 2018 11:47:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 24.7C.04062.3DC871C5; Mon, 17 Dec 2018 20:47:31 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20181217114731epcas2p3c20eea9fbfd1078be41efd456b7b0c73~xHEnzvDnI3165231652epcas2p3V;
 Mon, 17 Dec 2018 11:47:31 +0000 (GMT)
X-AuditID: b6c32a47-2f7ff70000000fde-3e-5c178cd33dde
Received: from epmmp1.local.host ( [203.254.227.16]) by
 epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7A.08.03627.2DC871C5; Mon, 17 Dec 2018 20:47:31 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJV00ELYQ33GT00@mmp1.samsung.com>; Mon, 17 Dec 2018 20:47:30 +0900 (KST)
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ARM: dts: exynos: Specify I2S assigned clocks in proper
 node
To: Greg KH <greg@kroah.com>, Krzysztof Kozlowski <krzk@kernel.org>
Message-id: <e47cd3e3-2861-859c-1d95-90bd325c3b5b@samsung.com>
Date: Mon, 17 Dec 2018 12:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-version: 1.0
In-reply-to: <20181214065900.GA22664@kroah.com>
Content-language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdljTTPdyj3iMwdV72hbzj5xjtTi3YAaj
 xfnzG9gtNj2+xmpxedccNosZ5/cxWbTuPcJusWDjI0YHDo9NqzrZPN4+DPDYvKTe4/MmuQCW
 KC6blNSczLLUIn27BK6M7TfvMhcs46vY9OIXWwPjU+4uRk4OCQETiS2zL7N1MXJxCAnsYJS4
 13KVGSQhJPCdUWJtnwRM0dHt/ewQ8d2MEnuvikA03GeU+LnpMSNIgk3AUKL3aB+YLSwQLPHx
 3QImEFtEwFlix47P7CANzAJbGSX2n14BNolXwE7iwIHZQEUcHCwCqhItXUUgYVGBCImO+6vZ
 IEoEJX5MvscCYnMK6Es8XP8LbCazgKbEiy+TWCBscYlj928yQtjyEpvXvGUG2SUhcJlNonvp
 IRaQ+RICLhJT7rpDPCMs8er4FnYIW1ri2aqNjBB2tcSu7d1QvR2MEi0XtjNDJKwlDh+/yAqx
 gE+i4/BfdoiZvBIdbUIQJR4Sk7e/YIUEyhVQoGxlm8AoOwvJD7OQ3D0Lyd2zkNy9gJFlFaNY
 akFxbnpqsVGBsV5xYm5xaV66XnJ+7iZGcNrQct/BuO2czyFGAQ5GJR7eC3vEYoRYE8uKK3MP
 MUpwMCuJ8PZaAoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzPpSeGy0kkJ5YkpqdmlqQWgSTZeLg
 lGpg3LP7CyvfBLPt9789mC6261SngsicpcUevkvvXuC4nn7obfBXzsrmCBW3+yL9b9iWlM5f
 y53SuXH/3liPnR8eicZo8OfPfMr6tE/7wd9ZtyLOsrz4oyjW9Gr5U48nnI89a4zUz8V0/44v
 WFuhtIHVdaPZveM2M1c5JO6zd+G/93Ei29zExXtUapRYijMSDbWYi4oTAV/qZvQXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jAd3LPeIxBt0vmSzmHznHanFuwQxG
 i/PnN7BbbHp8jdXi8q45bBYzzu9jsmjde4TdYsHGR4wOHB6bVnWyebx9GOCxeUm9x+dNcgEs
 UVw2Kak5mWWpRfp2CVwZ22/eZS5Yxlex6cUvtgbGp9xdjJwcEgImEke397N3MXJxCAnsZJS4
 /fANI0hCSOAho8Sjp7YgNpuAoUTv0T6wuLBAsMTHdwuYQGwRAWeJHTs+gzUzC2xllLj3Zzcr
 xKRrjBKXJ/5kBaniFbCTOHBgNlAHBweLgKpES1cRSFhUIELi7Mt1jBAlghI/Jt9jAbE5BfQl
 Hq7/BVbOLKAuMWVKLkiYWUBc4tj9m4wQtrzE5jVvmScwCsxC0j0LoWMWko5ZSDoWMLKsYpRM
 LSjOTc8tNiowykst1ytOzC0uzUvXS87P3cQIDP9th7X6dzA+XhJ/iFGAg1GJh/fCHrEYIdbE
 suLK3EOMEhzMSiK8vZZAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KL
 YLJMHJxSDYyr2lSN++7kcRik7bsq0jvPldOlg7PE43aK4LKV/l+rp+yTfjOrv23NOe81H9vC
 Nj0oTnI6sss25vunxyVZDTrvNlnk3zY3fryfK8uIce1Unz93T9t08cRf3s7HJGQvuHbhH6+2
 AlX/xxr2tWtVV3Bn7bItPnKN8dretW7LMvIqPp1i6Lyc9lqJpTgj0VCLuag4EQDd+Z27ewIA
 AA==
X-CMS-MailID: 20181217114731epcas2p3c20eea9fbfd1078be41efd456b7b0c73
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab
References: <CGME20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab@epcas2p2.samsung.com>
 <20181212175744.8287-1-s.nawrocki@samsung.com>
 <20181213205656.GA799@kozik-lap> <20181214065900.GA22664@kroah.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_034748_381678_6782C2EF 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/14/18 07:59, Greg KH wrote:
> On Thu, Dec 13, 2018 at 09:56:56PM +0100, Krzysztof Kozlowski wrote:
>> On Wed, Dec 12, 2018 at 06:57:44PM +0100, Sylwester Nawrocki wrote:
>>> The assigned parent clocks should be normally specified in the consumer
>>> device's DT node, this ensures respective driver always sees correct clock
>>> settings when required.
>>>
>>> This patch fixes regression in audio subsystem on Odroid XU3/XU4 boards
>>> that appeared after commits:
>>>
>>> 'commit 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")'
>>> 'commit 995e73e55f46 ("ASoC: samsung: i2s: Fix rclk_srcrate handling")'
>>> 'commit 48279c53fd1d ("ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access")'
>>>
>>> Without this patch the driver gets wrong clock as the I2S function (op_clk)
>>> clock in probe() and effectively the clock which is finally assigned from DT
>>> is not being enabled/disabled in the runtime resume/suspend ops.
>>>
>>> Without the above listed commits the EXYNOS_I2S_BUS clock was always set
>>> as parent of CLK_I2S_RCLK_SRC regardless of DT settings so there was no issue
>>> with not enabled EXYNOS_SCLK_I2S.
>>>
>>> Cc: stable@vger.kernel.org # v4.17+
>>
>> I gues your format would work (got recognized by stable scripts) but
>> strictly speaking format is different:
>>
>> 	Cc: <stable@vger.kernel.org> # 4.17.x
>>
>> https://elixir.bootlin.com/linux/latest/source/Documentation/process/stable-kernel-rules.rst#L127
>>
>> Thanks, fixed and applied.

Thanks for correcting this, indeed I just looked at existing usage 
in git log rather than at the documentation.

> Either works just fine, my scripts have to be a bit flexible due to all
> of the odd ways people like to tag things here...

-- 
Regards,
Sylwester

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
