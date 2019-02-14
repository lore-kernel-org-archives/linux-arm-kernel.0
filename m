Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D37C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:43:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77C8222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j1io6yr1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXo5CZBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77C8222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aQNkE4k4pE+fATA/3ctRSkCxikk9NjL0UO73t8umyJY=; b=j1io6yr1Y4r083
	jVuDWImgZ+RdfvdNxelq9nGQDTdainKPD1o7e93xKNObp5gZTgdav4YSEKZcPIwniQeqT+e7SkC5r
	zcXmYVkbzKXT+3f0QRW2iAbSScRp4j+5L0qdlSx5ONUb3k2NeKYsBOGuyUGEBnpX95x5plo56Vuxv
	Qq5P4e/vpXNd6wKYJ/FQDsXmsRGbWVXmAcXu4Gl4glQrFMCi72/9DONeN7he8wVV2n7D/0Dm5Njxo
	NNB0ufAYEvV46eohy//bPFALLYm20zOWb8qCsxLW+lkyDmcz42lPhMK+AwiwFarxTj3JiVZ/dIS4x
	giPi0bj0AmRa7h64EHAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guD3g-0001ba-Qw; Thu, 14 Feb 2019 09:11:52 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guD3U-0001P2-Fn
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:11:42 +0000
Received: by mail-vs1-xe43.google.com with SMTP id e16so3198583vsq.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 01:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eFBWiFIaqtau2CVEYcyX/n7Z0Eb/ey9J9D6DfDHhgzs=;
 b=lXo5CZBLyz09qu2yMefNbmTEv9ODDQ63Nr7/pO7A4Tfecbc8tRWL0VO+sjk1MMVIGV
 Pds4mYWbdz5Z3vXKWVHOasiXWH5oTdLG1Yacn+Vt89SaidIlI+NVDGiUVAOrMYA4t79W
 XwLkB4KhGd3mHKZcJf6J7zN9Zma8ycIZPSSD9X6M4yz4zQf2QrqzUYKU7Wzt7VZU49zz
 xvC6XXilhC1UZM4c4WhkZoTLMVgs9nHPw+krMkylz/E/e0/lII6yEm1mU0PV4fN6awyJ
 m+d43bDfjZtclBp7d2MIZiuaYj/ygrn+8umOK/6hviZ3uZsSkxINGXloPRjHIwl/fU+w
 gT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eFBWiFIaqtau2CVEYcyX/n7Z0Eb/ey9J9D6DfDHhgzs=;
 b=A0yKUSVUdiEwRtE2Qz6n+LKFDD1shpsGDBti5SDGl1x5hMBxYRedIJzHb9eJrtgGIl
 T1gV139AxV/DvCGdQbEnV+POnfFm429IyF2dINxoornPK7hOiq84nwV70aTaPJT15SKO
 RaXyJKJ675lh5k4rHgh3jhxRqO4ZgfCw0wXTCiXm5IQBqnr3QZ6k+B+Vmm1gosIsKlQD
 eet9BqYoRgIXNIqP6AQAxxLb9eouAsY7BI6wb15troOB764/PTcrmzO0A/qB6kany/EY
 3kJMd3ijUel71fbmAJgiZfuSFWzQd1kXkHt0C9QTRV57/F5gHY6VfRvkfgB0wS3Ms25/
 BWuw==
X-Gm-Message-State: AHQUAuY4BvcONoVGDXRDbP28FiZh86DqBoExT/j0QZHWRy0XLCSz42ZN
 37kZhUbXJmYMce3moALYPp26NRtYSXUWDa0f4V8=
X-Google-Smtp-Source: AHgI3Ia2bkMipgD+6KUp7PEUN+/FFL4FgtPyWHqMV1yVk97wsZcM/zTPsglMQF1pQ+Yk1LKK6+59/ArfIyaM4ujlVTo=
X-Received: by 2002:a67:edca:: with SMTP id e10mr1418794vsp.196.1550135498946; 
 Thu, 14 Feb 2019 01:11:38 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
 <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
 <CAOuPNLgUvECE6XBjszFggY3efmEBKywzKNWupjfQ2svsCMqd7w@mail.gmail.com>
 <2c91af7d-4580-cedc-70ea-d38c2587c7bf@codeaurora.org>
In-Reply-To: <2c91af7d-4580-cedc-70ea-d38c2587c7bf@codeaurora.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Thu, 14 Feb 2019 14:41:27 +0530
Message-ID: <CAOuPNLip6rwxC1DdDiCb28d5+uJNE9=ThCn+rjac854GkcnedA@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/rwsem.c:65
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_011140_759424_44C78039 
X-CRM114-Status: GOOD (  25.61  )
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
Cc: linux-rt-users@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 "Xenomai@xenomai.org" <xenomai@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Sai,

Thanks so much for your help.

On Thu, Feb 14, 2019 at 12:14 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi,
>
> On 2/13/2019 8:10 PM, Pintu Agarwal wrote:
> > OK thanks for your suggestions. sdm845-perf_defconfig did not work for
> > me. The target did not boot.
>
> Perf defconfig works fine. You need to enable serial console with below
> config added to perf defconfig.
>
> CONFIG_SERIAL_MSM_GENI_CONSOLE=y
>
Actually for me the kernel does not boot. It stuck in bootloader, with
"valid dtb not found".
I did not debug it further.
Anyways, we can look into this issue later.

> > However, disabling CONFIG_PANIC_ON_SCHED_BUG works, and I got a root
> > shell at least.
>
> >
> > But this seems to be a work around.
> > I still get a back trace in kernel logs from many different places.
> > So, it looks like there is some code in qualcomm specific drivers that
> > is calling a sleeping method from invalid context.
> > How to find that...
> > If this fix is already available in latest version, please let me know.
> >
>
> Seems like interrupts are disabled when down_write_killable() is called.
> It's not the drivers that is calling the sleeping method which can  be
> seen from the log.
>
> [   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
> [   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90         <---
> [   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80   <---
> [   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208      <---
> [   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
> [   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f0
> [   22.174763] [<ffffff88b8e560ec>]
> do_execveat_common.isra.15+0x504/0x6c8
> [   22.181452] [<ffffff88b8e562f4>] do_execve+0x44/0x58
> [   22.186481] [<ffffff88b8c84030>] run_init_process+0x38/0x48      <---
> [   22.192122] [<ffffff88b9d3db1c>] kernel_init+0x8c/0x108
> [   22.197411] [<ffffff88b8c83f00>] ret_from_fork+0x10/0x50
>
Yes, these are generic API, and I don't expect any changes in here.
We don't have this issue in another SOC 4.9 kernel.
Also I compared these APIs with mainline and there is no major changes here.
This is just one example.
This sleep issue is happening from other places as well.
May be one common similarity may be: during task loading, or switching.

>  >
>  > This at least proves that there is no issue in core ipipe patches, and
>  > I can proceed.
>
> I doubt the *IPIPE patches*. You said you removed the configs, but all
> code are not under IPIPE configs and as I see there are lots of
> changes to interrupt code in general with ipipe.
>
We observed that this issue is happening in normal sdm845 kernel as
well (without ipipe/xenomai patches applied in another branch).
Another point is, we don't see this issue in another arm64 target such
as hikey, with same 4.9 kernel.

> So to actually confirm whether the issue is with qcom drivers or ipipe,
> please *remove ipipe patches (not just configs)* and boot.
> Also paste the full dmesg logs for these 2 cases(with and without
> ipipe).
>
hmmm. This will be little tough.
I will try to find sometime to point the exact cause, and share findings here.
Currently, I am debugging another issue.

Thanks for your help.


Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
