Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39CEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:37:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB7D20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NMc9RLyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB7D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wk/HR9v4n2/2fnPlSF9XfNkXv0nM+eUvOHNugvb3hKE=; b=NMc9RLyjA1ORnH
	ye8arlP+aIcwVcl7V/j0tVtCFNIFfg2N6sbVKTrn1SqXPYpnFsi+ST3gVEC2ZNKEHNz0Kl6QmsYd/
	upzSqB4Pd8R+Kthmb+JaEm4RkS9/jyEAM6Ka/JRkuyAJ5pF+wiYJOHsZPWMi/IkXoWiMEO3fCY/v+
	j2pdZT0Lvbjs3WTqRDesGWxYX8DvkmfUt1BAiaPZ9jpbiqgKuzadKKfDdcOHsKIKAy0Rh8lxy79Eu
	XiUE4iG6DpcrfEZDNhxOMMwbmJsYoahZzCPsMVTXCC0zusBcRCaa97Z4OpnUkozfgIoOQfAHdAErd
	2l28WlchOFi+hRSlkiWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghh4W-0004sO-He; Thu, 10 Jan 2019 20:37:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghh4S-0004rs-Dd
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:36:57 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0AKYMsP059831
 for <linux-arm-kernel@lists.infradead.org>; Thu, 10 Jan 2019 15:36:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pxd32gbed-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Thu, 10 Jan 2019 15:36:55 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <heiko.carstens@de.ibm.com>;
 Thu, 10 Jan 2019 20:36:52 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Jan 2019 20:36:42 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0AKaflZ15859874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Jan 2019 20:36:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BB5742042;
 Thu, 10 Jan 2019 20:36:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 065314203F;
 Thu, 10 Jan 2019 20:36:40 +0000 (GMT)
Received: from osiris (unknown [9.145.24.85])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Jan 2019 20:36:39 +0000 (GMT)
Date: Thu, 10 Jan 2019 21:36:38 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-16-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190110162435.309262-16-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19011020-0020-0000-0000-000003049593
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011020-0021-0000-0000-000021559B2E
Message-Id: <20190110203638.GB3676@osiris>
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-10_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=954 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100159
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_123656_584312_608258CF 
X-CRM114-Status: GOOD (  22.00  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 linux-mips@vger.kernel.org, jcmvbkbc@gmail.com, deepa.kernel@gmail.com,
 hpa@zytor.com, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 dave@stgolabs.net, y2038@lists.linaro.org, mpe@ellerman.id.au, deller@gmx.de,
 x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:
> Most architectures define system call numbers for the rseq and pkey system
> calls, even when they don't support the features, and perhaps never will.
> 
> Only a few architectures are missing these, so just define them anyway
> for consistency. If we decide to add them later to one of these, the
> system call numbers won't get out of sync then.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
> index a1fbf15d53aa..ed08f114ee91 100644
> --- a/arch/s390/include/asm/unistd.h
> +++ b/arch/s390/include/asm/unistd.h
> @@ -11,9 +11,6 @@
>  #include <asm/unistd_nr.h>
> 
>  #define __IGNORE_time
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> 
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_OLD_READDIR
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 428cf512a757..f84ea364a302 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -391,6 +391,9 @@
>  381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
>  382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
>  383  common	rseq			sys_rseq			compat_sys_rseq
> +384  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
> +385  common	pkey_free		sys_pkey_free			sys_pkey_free
> +386  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect

Since you only need/want the system call numbers, could you please
change these lines to:

> +384  common	pkey_alloc		-				-
> +385  common	pkey_free		-				-
> +386  common	pkey_mprotect		-				-

Otherwise it _looks_ like we would need compat wrappers here as well,
even though all of them would just jump to sys_ni_syscall() in this
case. Making this explicit seems to better.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
