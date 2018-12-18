Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F640C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:12:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DDB21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjR0L9R9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPjz+9iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DDB21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UW60EorlsB91gMPV+nzHcBLQcADbg37lceixZPxBUVg=; b=fjR0L9R9BSoFdi
	AEOK6AaljCC1lJ/35kRKPPWQ3ZKK9ooyPPLVA0fSSiE69EbQF9kOns8Hv0PqH1mAvvkO3bVnlss1n
	PApB1qcFe9r+61YIMJB4rSeQseOEdurvioodYztNld0kjhm6yKqvLJ/E3ywbJ5qUey6KLpN6zV50o
	ZvmLT23+lFbZk0e0ot6g6vdElgE3q7xL4D0A+jGGbaSal4MyxgQxwU9+Onp4DLJ4u66nICVy6xojv
	5S8b+onG5ILMMaMnHuupeDIRx2JTKAJ12Kw3hSFRc1E4FqZVGnU8ZX28dWk1fPZYTJ/nknv2mOlIL
	HnPQhjWg//eYnrrbJVaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZH38-0006ls-D9; Tue, 18 Dec 2018 15:12:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZH35-0006lA-Jk
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:12:44 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1EC121871;
 Tue, 18 Dec 2018 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545145952;
 bh=8Q4eZ8594DtSKWB2e+2mmCyVzsNilZD31iQ4WDodpxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QPjz+9iGGOhxNQdjSkLMzgPocoibi5BIHhy1Z84bN4AJcyiNC4g2lJz3+xC42LuKF
 zFtR0FA8SbiZsfzY1cRh5uWT9kDVc9GH0qT6ZJ0x1EuF1ESSnicdnIhghWfVWPsii1
 uEW82Bug+Q8YAmH60lGSk41VmrGb5Tk6x2/PhSnM=
Date: Tue, 18 Dec 2018 16:12:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 0/7] v4.19-stable randconfig fixes
Message-ID: <20181218151230.GA30844@kroah.com>
References: <20181214221023.3878670-1-arnd@arndb.de>
 <20181218002028.GX2746@sasha-vm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218002028.GX2746@sasha-vm>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_071243_683442_F429A652 
X-CRM114-Status: GOOD (  20.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-aspeed@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, David Brown <david.brown@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-i2c@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Daniel Drake <dsd@laptop.org>, linux-scsi@vger.kernel.org,
 Jens Frederich <jfrederich@gmail.com>, openbmc@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
 dou_liyang@163.com, Rob Herring <robh+dt@kernel.org>, bp@alien8.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 07:20:28PM -0500, Sasha Levin wrote:
> On Fri, Dec 14, 2018 at 11:10:05PM +0100, Arnd Bergmann wrote:
> > Hi Greg,
> > 
> > I did some randconfig testing on linux-4.19 arm/arm64/x86. So far I needed
> > 27 patches, most of which are also still needed in mainline Linux. I
> > had submitted some before, and others were not submitted previously
> > for some reason. I'll try to get those fixed in mainline and then
> > make sure we get them into 4.19 as well.
> > 
> > This series for now contains four patches that did make it into mainline:
> > 
> > 2e6ae11dd0d1 ("slimbus: ngd: mark PM functions as __maybe_unused")
> > 33f49571d750 ("staging: olpc_dcon: add a missing dependency")
> > 0eeec01488da ("scsi: raid_attrs: fix unused variable warning")
> > 11d4afd4ff66 ("sched/pelt: Fix warning and clean up IRQ PELT config")
> > 
> > Feel free to either cherry-pick those from mainline or apply the
> > patch from this series, whichever works best for you.
> > 
> > The other three patches are for warnings in code that got removed in
> > mainline kernels:
> > 
> > 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
> > 972910948fb6 ("ARM: dts: qcom: Remove Arrow SD600 eval board")
> > effec874792f ("drm/msm/dpu: Remove dpu_dbg")
> > 
> > My feeling was that it's safer to just address the warning by fixing
> > the code correctly in each of these cases, but if you disagree,
> > applying the mainline change should work equally well, so decide
> > for yourself.
> 
> Thanks Arnd, I took the series as is.
> 
> We really need to discuss how -stable deals with removed code upstream.
> For some cases, we should probably follow suit and remove it from
> -stable as well (I'm mostly thinking dodgy code with potential security
> issues).

It would be nice to do that at times (like lustre and ipx), but it's
good to keep that code around as maybe someone is using it?  I don't
know, it's a tough call...

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
