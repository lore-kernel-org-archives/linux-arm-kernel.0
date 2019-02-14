Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45900C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:49:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CC821B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHSOxZI8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="hvEkx0sD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CC821B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n0aiW2Wr8JVSEilg5X9QxqI8vF0W/D7VBrjnzon+b40=; b=SHSOxZI8w2yqUy
	IQ3iFCMTURMkgl33CiNHQTapYnL/yCz70KMMoPDj2qrCMB7Wcx35I2QW1COMQKg8gGphiPMUHn/Bk
	luhvVi793ZLeytE/OOf+CwE3fEHP+Z6zAWhtX5tb3EUFmGirYXBxHvNvJEr23oWrPyf+pixwcNtP+
	MFtco6N8pc3Y1dCgSYbTQzOG6LAKu0GkYGX/tIKXRFy4aJmXR5yTgnRx7dPNr6ebpdoZJsVOIytRX
	tRyntwWt0m6U5/AOos3Q7aqiogek4MPJbKSiLKMhA0lZTUbYGo3QVVHbuJa4Q3zg6GhKLTniAhrGi
	Cx2rqy/rQTyvMFC/9F1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQlN-0002Wr-RM; Thu, 14 Feb 2019 23:49:53 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQlK-0002Ud-5w
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 23:49:51 +0000
Received: by mail-qt1-x842.google.com with SMTP id j36so8989194qta.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 15:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tycho-ws.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iysI1wB/0IWb4pCFfVwtSNZMVU6oGg5xTMZgAA4BlqY=;
 b=hvEkx0sDae+vXuPkRrfz6GJpMcmtwOQoFSjorPtzJ7i/ZlZ+N2DS8RHhtUbzd2y8aO
 93zCFM5f7/VQorSYljRscCmvDMT6v89kczMv5nSnCHvFEegerCJ6Xb764Nd59OwMZGh2
 NR0NbloEkvUqHfCWvo4BrQcaPp8/NpqhtjLmAQgxztm5ByUDgCAXzPDq+BlqmiBG8EGV
 ME/1vaG7H5+GvHHBdTqNAFIcuC2Ueippty3sTQasR/b//BeWt+Za8V6wljLiKAfeu1Ua
 8dD/hcP3II2Mhhb9gsYGvTIhagIB+dNDWETUdvkn94BpgBZq/gWHYermiCVlUERwF+Bk
 K6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iysI1wB/0IWb4pCFfVwtSNZMVU6oGg5xTMZgAA4BlqY=;
 b=qHStHHkaVY4WYAkuJYCmQxZxFAZedYVEKV1jrRXnEZNSdVPYly+RmaysUDB59omxgA
 NCdHwsTzWNOR9A6GcFIRRhuiysbGJu5zGj6WSmxye2wAyAMsTckWdl2SHEYnzChCnKJF
 +EZJD9DbRFJbrO5csL2eu3IXnJZJEsnMvMavZ36S166QByD/XiN4oa9fmzreVPV5vAMi
 a+0MMAPhApZHQ6vB4jxfNheMq1zD8NZFT91S/yk5OVlll/ldq2VcwE83MZYwJ9fxvGmp
 ynMhvsj/DgV7nGLvDycW8U6a+Nq/3OjWPr2NQgg/wmcn1qOEf3lokEI3af9y9YI4Zkad
 lwNw==
X-Gm-Message-State: AHQUAuZIwew+Tr7Va09beAOwptUe3MXMmLHMMCCpEPfYamQqn8yGRrNR
 ZwtY8gTDQr9A8fERe5NjBNwoEg==
X-Google-Smtp-Source: AHgI3IZknsyHISGjxlHiQOHLeB8lB0ycvuC7u1AyuZY91RkGx/hANlj0RYTPcWTfc+1rGg/X944lrg==
X-Received: by 2002:ac8:969:: with SMTP id z38mr5363680qth.49.1550188188860;
 Thu, 14 Feb 2019 15:49:48 -0800 (PST)
Received: from cisco ([192.241.255.151])
 by smtp.gmail.com with ESMTPSA id y68sm1965923qkd.49.2019.02.14.15.49.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 15:49:48 -0800 (PST)
Date: Thu, 14 Feb 2019 16:49:43 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v8 07/14] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190214234943.GF15694@cisco>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <ea50404604bdbe1547601b6ea0af89e3da8886b0.1550088114.git.khalid.aziz@oracle.com>
 <20190214155435.GA15694@cisco>
 <92787149-bb9e-6ee9-6d04-431ec145e9a4@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92787149-bb9e-6ee9-6d04-431ec145e9a4@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_154950_304605_6E2C026C 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: mhocko@suse.com, kernel-hardening@lists.openwall.com, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, dave.hansen@intel.com,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, tglx@linutronix.de, ak@linux.intel.com,
 x86@kernel.org, jmorris@namei.org, hch@lst.de, kanth.ghatraju@oracle.com,
 jsteckli@amazon.de, labbott@redhat.com, pradeep.vincent@oracle.com,
 konrad.wilk@oracle.com, jcm@redhat.com, liran.alon@oracle.com, luto@kernel.org,
 boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, linux-mm@kvack.org,
 juergh@gmail.com, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
 tyhicks@canonical.com, john.haxby@oracle.com,
 Juerg Haefliger <juerg.haefliger@canonical.com>,
 kirill.shutemov@linux.intel.com, keescook@google.com,
 akpm@linux-foundation.org, torvalds@linux-foundation.org, dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 10:29:52AM -0700, Khalid Aziz wrote:
> On a side note, do you mind if I update your address in your
> signed-off-by from tycho@docker.com when I send the next version of this
> series?

Sure that would be great thanks. This e-mail is a good one to use.

Cheers,

Tycho

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
