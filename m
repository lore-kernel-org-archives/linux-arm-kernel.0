Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B3C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:04:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F872082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MruMFkcx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pBuGD/7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F872082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5w4AKNwMUGcX+My2o+D32cETaZx8DDd2Flj+kJdb6pE=; b=MruMFkcxxJ6KXl
	dPRJvejrsafFfUMhYRvo2m50EPtF1LRmfrRrrouV7cD2inZAfCjz12NjYDzkViA4+WuCt9dgSutM8
	CNqPPVbhjTZsmPHoks8qlWo5H0gLLWi67VKWqTj5IB9HJn22gjtKsXyw59fxI1EtffHisqXmwqekj
	/pzk/3Bmm0LY4Kag1SSNygCy//yyjBDX8hRfET+Wdgfch3SKfDTUlaNfkPsU1jcYj6qnqE5vsKC7s
	kZQXLO9hcVCixjT4CFxy2F0LRSHb3zy2AO1ZpubSYQLWWMf9YoRkeSBE5rDmnfSMKkUWI5c3/pvku
	iUr6uJj22IQIPzS9seLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbIV-0001r5-Mo; Fri, 01 Feb 2019 16:04:07 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbIU-0001qw-1o
 for linux-arm-kernel@bombadil.infradead.org; Fri, 01 Feb 2019 16:04:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iMdWlS+Wv0tKThwiMyMbj7vGWEETNTZ8CrNjlnY40lw=; b=pBuGD/7yBTM4ABLZJwgjx4YcP
 xAMFyzudG4Ooz7ejJa/bBG3+XB5Wdudx2DQPtersVZ7aPzAE+CO1ufR5zVmVEP+6ArSo5T7k02G/Y
 ytO0N2svGfJ7ri+G6h/h1q1NsNCkWUqIPO8QL7JNADN+WKx1Sh6VdQSCcYNbp8PjejBeXkBTV8FIy
 H0MIhtu3tph/MaXQYGW5V/ACucSKwquvb5rtIWPllD2ndFXZ5htFDuK/LBdwd5Mms5FU4eX6PNzX9
 8zlmgb5PZoPZazfdRnIXojcDeTNMZ9YnhaebISml/h2LGYpTr6oA9GPReBpxwjg7QzntyCKncMjvL
 JCQ/jy+CA==;
Received: from [94.113.247.3] (helo=quaco.ghostprotocols.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbIR-0002W7-Ho; Fri, 01 Feb 2019 16:04:04 +0000
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id E0FDB4034F; Fri,  1 Feb 2019 17:03:59 +0100 (CET)
Date: Fri, 1 Feb 2019 17:03:59 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v3 7/7] perf tools: Remove PMU::set_drv_config API
Message-ID: <20190201160359.GB8839@kernel.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
 <20190131184714.20388-8-mathieu.poirier@linaro.org>
 <695e25a7-d1f0-d764-493e-4c64310ef16b@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <695e25a7-d1f0-d764-493e-4c64310ef16b@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org,
 mathieu.poirier@linaro.org, peterz@infradead.org, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com,
 ast@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com,
 linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com,
 namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Em Thu, Jan 31, 2019 at 07:03:48PM +0000, Suzuki K Poulose escreveu:
> On 31/01/2019 18:47, Mathieu Poirier wrote:
> > CoreSight was the only client of the PMU's set_drv_config() API.  Now
> > that it is no longer needed by CoreSight remove it from the code base.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I'm processing the patchkit, test building it on a cross arch64 build.

- Arnaldo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
