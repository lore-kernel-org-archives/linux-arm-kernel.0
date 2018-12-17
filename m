Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFFAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:38:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D817204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EfDzWhx4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V+i/Fhbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D817204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BIh8JNnD/M3n3tdLAqhPC1DXWxt6oxkeTeUn86a4abM=; b=EfDzWhx4u6nlcQ
	cYZwFTpzKRCsYqrJXUvmQXBHtJDW3WEFXYzaRYHNsCpR7+3mEJew+D0ESczsMKlWrdOqvbZo0PQx9
	qgKS8PgXnodBEWQAEuE4KfHB/7ba+ixp7hwZaX15c9/G0bFIh5aU9ig2z28M2IJV1v2VuSFWWPE3A
	jhKZUXThaPcyHhxPR2qFsZutmFRAuk23KoH28pjxycCxC7O09+aK/rveUmx9+sGHMfKwszDhEEgYb
	p7RMynVwNTrINz3kANp5+BN0DXCmD6gWKL32OIqXUuS/50DQyv+4Bo4Kf9t4y0Xcr5JykgNZK92Fi
	/PkEARGezz7htjIUKr9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYrEU-0000my-6n; Mon, 17 Dec 2018 11:38:46 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrEQ-0000mO-6k
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 11:38:43 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c178ab10001>; Mon, 17 Dec 2018 03:38:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 17 Dec 2018 03:38:30 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 03:38:30 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 17 Dec 2018 11:38:30 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 36C364297E; Mon, 17 Dec 2018 13:38:28 +0200 (EET)
Date: Mon, 17 Dec 2018 13:38:28 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V2 09/21] clk: tegra: dfll: add protection for
 find_vdd_map APIs
Message-ID: <20181217113828.GC7714@pdeschrijver-desktop.Nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-10-josephl@nvidia.com>
 <a56194ce-ce96-8b3a-99e8-b4348db39f42@nvidia.com>
 <acaf37e4-e581-597f-fdcf-5f627e396b88@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acaf37e4-e581-597f-fdcf-5f627e396b88@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545046705; bh=QQqymI3NnYPrt5qqeePtJ6Sj8cjlkAgakNJcbMwbCIg=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=V+i/Fhbp5pQEXNuExEa8q9oL/oARdvSeD1P/1DShRHILADHqnECxztTpltDLIKXGj
 eus5L3GeLFw/OsBip+ccd5Uid+fiCWGOFoQUJwfWXkqBzFGy304ry1BeWRkERvE6N+
 0J98qAjq6whUNXupxwpzstbOCQLco1qGjtkb5HnScnaC66zqy8bTEKSUW1zkVzaPXg
 TzHuXT6rwG12xRqi2uH+mk4xI3gmytzM08qzJbeeu047TdOmWaDoMTau6EDGIyjUYN
 v4trKhjAqDN1gJi6BfQ7IfT3hPaBwheEY7kkPC02bWGHXRCJWeK3DshYCPRcC6Zwok
 mKg0tPh6mXMLg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_033842_260237_F812A804 
X-CRM114-Status: GOOD (  16.54  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 03:42:45PM +0800, Joseph Lo wrote:
> On 12/13/18 8:46 PM, Jon Hunter wrote:
> > 
> > On 13/12/2018 09:34, Joseph Lo wrote:
> > > The DFLL hardware supports both I2C and PWM based regulator. SW driver
> > > only touches I2C regulator when generating LUT. And shouldn't touch it
> > > anymore once the DFLL is enabled.
> > 
> > I am not sure that the last two sentences are above are relevant and
> > confused me a little at first. I would be tempted to drop them.
> 
> Indeed, they are irrelevant. Just want to describe that once we created LUT
> table, it means we cached the regulator output table in driver. Then we
> don't need to query voltage data from regulator again. This is specific to
> the I2C mode only and happens in driver initialization time. Which means the
> two APIs we add the WARN here maybe not really necessary. Because this is
> suggested by Peter.
> 
> Hi Peter,
> 
> Just want to double confirm again, do we really need to add a WARN here?
> Since we don't and shouldn't access these two APIs once the driver is
> working, all the voltage query should be via LUT. So I think add WARN here
> is not really necessary.

It's not really necessary. It's more of a safeguard to make sure someone
who modifies the code later and might not be aware of this limitation
would accidently call the functions when PWM mode is in use.

Peter.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
