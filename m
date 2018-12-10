Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090EEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:05:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C945B2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MvdYEgrm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ui+aGj4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C945B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gNXrzqFex8uQc8M1GFsQQ13kvbNSc1AxXvyOw+JAeVA=; b=MvdYEgrmUn2c2Q
	X3TuXgTE15O6KJPSf7PFcCACByb+f0YArWmTPXamlwVrj4nTjtBz2IaNcctV84CQjxP/kyLp8HlgS
	Znun85mhmaoy8Riu7R8kQkfF8Iy6+uDxcHIn3vFKaVCWeqP+61yFotaGpPJ9AtCU+Y9QfSNaxWupo
	bJjv3bscICwoM6iNco7Xm7IH5M0IcDzlI+4uGvMqt5RFZTYbT8rhBwLFk3epBn2e4rXKKtgdQGlDz
	JkraqS6yDErxaMZJLOPNqP7TebYvtWtevKg7STYBXqwiQpiQKNwSnC/8xohk30Xl1smAUx9RmGDXN
	kzLVJTervb9Vmlod04uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQrx-0004hI-3j; Mon, 10 Dec 2018 19:05:29 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQru-0004fi-UW
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:05:28 +0000
Received: by mail-ot1-x343.google.com with SMTP id a11so11488827otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7SUu/lyKL9Wf2JrMSYtA/5vF7FuD3ePKhKiwfJjQjvA=;
 b=Ui+aGj4QXyH6Y0L1ERqvoQHQJaYvaiKHG3zk97ot328FaobPFB2oYFGh+p2lUe0tPl
 +EK6/bNlyRN+NtjJlCMGbTPnDKnufSz6zR/C5XoeU9YjXJAtsK5vfy0p83KQ5/sJb7i8
 PdJ1Nkbw3nzRR9amdGWO/B87UsMQaDbKngEzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7SUu/lyKL9Wf2JrMSYtA/5vF7FuD3ePKhKiwfJjQjvA=;
 b=O6st/Vbt/ES9PT9tBmgijbRfPG8deAhJE5oSmNcVuRK4CPEQLkgiuMHYqLVsBHnBNX
 iCEpq1ayf3pScsGb6Qrj5S72v/g7WoUO9TxD5rJEB7ImEvBewEiUEXoZV9v65GL1kbIk
 Vwwq3Beo5hjWXTwe80Hp/1wwrUc2ZqshJ49SuGeu+hj4nasHCe2L7ym8FASZMgaoQ+3P
 rnk8smlH+3RlaXpP+E8xn12sc1SGxNJyKoI63Y7HrsBjsww/3RwvZLn7cwGcfa+cxQwp
 4SkoL/SqsXUgT2orN4X31MBMLFUSsUZBmm1psdaskmszEaaqvpXZl5r2erCPCzAQP11N
 cw/g==
X-Gm-Message-State: AA+aEWa5tOJ97GpMt67V8b28mlZE3Ecco0LjBgBXAW2kfyggu2vn44CM
 3WXGjuiYJo9GXm33N6nggDcxEg==
X-Google-Smtp-Source: AFSGD/XoOrY/Zz8ADlqf2KGwZeCBF58UmsKD+4rdcnD6w3aWnO84/h5qGAd0288ER5MAdLdxUXRGyg==
X-Received: by 2002:a9d:886:: with SMTP id 6mr10012948otf.256.1544468715086;
 Mon, 10 Dec 2018 11:05:15 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:79bb:a266:cd71:3186])
 by smtp.gmail.com with ESMTPSA id m25sm5458255otq.32.2018.12.10.11.05.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 11:05:14 -0800 (PST)
Date: Mon, 10 Dec 2018 13:05:13 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
Message-ID: <20181210190513.GA25288@hector.attlocal.net>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
 <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
 <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_110526_981528_0A7FE3EF 
X-CRM114-Status: GOOD (  17.55  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 arm@kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 02:20:47PM +0200, Stanimir Varbanov wrote:
> Hi Andy,
> 
> On 12/8/18 7:13 AM, Andy Gross wrote:
> > The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:
> > 
> >   drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2
> > 
> > for you to fetch changes up to 92def04bd7b46f5b186f985d5c9d3804858c3c2f:
> > 
> >   MAINTAINERS: Change Todor Tomov's email address (2018-12-05 16:45:34 -0600)
> > 
> > ----------------------------------------------------------------
> > Qualcomm ARM Based Driver Updates for v4.21 Part 2
> > 
> > * Fix MAINTAINERS email address for Todor
> > * Fix SCM compilation error
> > 
> > ----------------------------------------------------------------
> > Jonathan Marek (1):
> >       firmware: qcom: scm: fix compilation error when disabled
> > 
> > Todor Tomov (1):
> >       MAINTAINERS: Change Todor Tomov's email address
> 
> I saw this patch is applied also in media_tree.git, not sure that is
> problem though.

Which one?  The maintainer or the scm?

Andy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
