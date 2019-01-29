Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E474AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:59:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91792175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d200mO8N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e4JQw+Gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91792175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N+obfuWYcgh67mu+lvZjQbqdg+jLTqG2kbuJ6bcixfU=; b=d200mO8N0Qn0aD
	yx8sNpjec9uD2qrW2761foV1jTjhCdU9q1CmrnMvlP+XwgQveatR59vAeRIWBS8JI0AtceLu7wUPG
	+MEDXnPZgUxJ5lxAbucJyo/YyVUx0HtWxJs0sx2chwY6aHB/0CZJlbotE/yR08Me+cqH90pCQSQU1
	NNQ17afz0h9/faWNhvP1+nYPlhAnEfKCfvtSMBjpmMAHnI69GL7IeqUdos0pu0hTe064sEz9gC1l0
	TwXHzdyXvezgUxHF5zHBkSvlZ2oQZtYLjsZFccmvm2mSOi4hggW2MXIQE6HhSZHdWmZBIFFbmsfcs
	Zn/9Yxypmvy5RpQHmTxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUrj-0001Oe-E0; Tue, 29 Jan 2019 14:59:55 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUri-0001OW-Fn
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 14:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bpok+/RycEtZupHiAdTqfud8JgaqhJf69hEkrbMlRms=; b=e4JQw+GbCSlD+OgDgNNR+6IlHV
 WTKKm+ogRcuwEjBGh+Q4Zjf2k09rbWJz9M7wUHl/NjLYSe+HJrzVxnm4PAF8LfA9rfl7ajUYbFJf2
 URQd0DI/pXIHi3ASPwZ7UFCYImHLFnws1wHB8CO0ZeDAw3eoqiXwy8esD/7GwWgEXkEeqyUcrLZEi
 l+CLwnJ3t46qa7bv0m0DQiVmn8//mun8Rml4cvIa3WtNDOnnEEX72/26m0b/UzAotEMObsmXDsC+L
 4USWC4jlL/QgoKWW5qBW7Siitp6DU+7jFeJacmIkPg+Kups6BIAXGWrETG4oDEmDHjfjav9rew2za
 IN50slNw==;
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUre-0002Jf-LO
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:59:52 +0000
X-Originating-IP: 90.88.147.226
Received: from windsurf (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C84841BF20D;
 Tue, 29 Jan 2019 14:59:14 +0000 (UTC)
Date: Tue, 29 Jan 2019 15:59:13 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: Out-of-tree mwlwifi driver crashes
Message-ID: <20190129155913.163f1e98@windsurf>
In-Reply-To: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_095950_806228_0AF975D2 
X-CRM114-Status: GOOD (  19.52  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Leigh,

On Tue, 29 Jan 2019 13:47:38 +0000
Leigh Brown <leigh@solinno.co.uk> wrote:

> The following commit causes the out-of-tree mwlwifi driver [1] to crash, 
> which
> I have found with git bisect.
> 
> commit 1f08673eef1236f7d02d93fcf596bb8531ef0d12
> Author: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Date:   Thu Oct 18 17:37:18 2018 +0200
> 
>      PCI: mvebu: Convert to PCI emulated bridge config space
> 
>      Convert the pci-mvebu driver to use the pci-bridge-emul logic, that
>      helps emulating a root port PCI bridge configuration space.
> 
>      Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>      [lorenzo.pieralisi@arm.com: updated commit log]
>      Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> I have raised the issue with the driver maintainers but they responded 
> that
> this is a kernel regression [2].
> 
> Do you think this is a driver issue or a regression? I am happy to test 
> proposed
> fixes but I don't understand enough about the driver or PCI to 
> investigate.
> 
> If I revert that single commit, the issue goes away.

Thanks a lot for this report. This is the second report related to this
commit. I already started investigating, but didn't dedicate enough
time to find a proper fix yet.

Could you share the output of "lspci -vvv -xxx" with the commit applied
and reverted ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
