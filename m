Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA01FC6195
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:15:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D465B20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PVpT3D0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D465B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oVDvepbrkJPsfQEs/NOZadYETMb0QXecl7YZjy9Clf4=; b=PVpT3D0UgTf2Pf
	AJHkuj0HMLcTDkoiYeWqAVO8pH96+rOTdrUYAA1BATmQb4KmZbXsvk1AIBmkXvX0TRVyhHvojpqXg
	LKF9cqaH3y3nKX79Q6s29lziqo68ukV2YS9vj4uesc4yqb63i2FaObMs0ZWR/i9Mr8NQVb/w3+Vpo
	JaMyDgYGWj8iCw9BYUGbiRgZR1ezS8tS0bdf3cHfO5paOTFyS1afZGoutWwcNy/tS8EJDq7u+17Ps
	sG3nyUcQATifad6rQGvipuEQYXSFfVZ+GtsmNOiOJVI3zjSkWBbqJg3KFJVzXb5BsAqYwokQY67hH
	VIsUwC2jKgE9mG4WChSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYUQ-0000aj-V0; Mon, 21 Jan 2019 12:15:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYUK-0000a2-6i
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:15:41 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0LC3xbl103097
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 07:15:35 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q5bh9ek3w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 07:15:35 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <heiko.carstens@de.ibm.com>;
 Mon, 21 Jan 2019 12:15:32 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 12:15:22 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0LCFLl829687808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 12:15:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ADEC11C066;
 Mon, 21 Jan 2019 12:15:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 921E611C04C;
 Mon, 21 Jan 2019 12:15:20 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jan 2019 12:15:20 +0000 (GMT)
Date: Mon, 21 Jan 2019 13:15:19 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 28/29] y2038: rename old time and utime syscalls
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-29-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190118161835.2259170-29-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19012112-0016-0000-0000-0000024848AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012112-0017-0000-0000-000032A27988
Message-Id: <20190121121519.GE4020@osiris>
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=663 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_041536_366174_6A340EC2 
X-CRM114-Status: GOOD (  22.63  )
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
 benh@kernel.crashing.org, will.deacon@arm.com, linux-mips@vger.kernel.org,
 jcmvbkbc@gmail.com, netdev@vger.kernel.org, deepa.kernel@gmail.com,
 hpa@zytor.com, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, y2038@lists.linaro.org, mpe@ellerman.id.au,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, catalin.marinas@arm.com, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, linux-fsdevel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 05:18:34PM +0100, Arnd Bergmann wrote:
> The time, stime, utime, utimes, and futimesat system calls are only
> used on older architectures, and we do not provide y2038 safe variants
> of them, as they are replaced by clock_gettime64, clock_settime64,
> and utimensat_time64.
> 
> However, for consistency it seems better to have the 32-bit architectures
> that still use them call the "time32" entry points (leaving the
> traditional handlers for the 64-bit architectures), like we do for system
> calls that now require two versions.
> 
> Note: We used to always define __ARCH_WANT_SYS_TIME and
> __ARCH_WANT_SYS_UTIME and only set __ARCH_WANT_COMPAT_SYS_TIME and
> __ARCH_WANT_SYS_UTIME32 for compat mode on 64-bit kernels. Now this is
> reversed: only 64-bit architectures set __ARCH_WANT_SYS_TIME/UTIME, while
> we need __ARCH_WANT_SYS_TIME32/UTIME32 for 32-bit architectures and compat
> mode. The resulting asm/unistd.h changes look a bit counterintuitive.
> 
> This is only a cleanup patch and it should not change any behavior.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
...
>  arch/s390/include/asm/unistd.h              |  2 +-

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
