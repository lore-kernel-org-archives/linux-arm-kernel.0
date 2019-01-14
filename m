Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE74C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:52:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654F0206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BK0WlLIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654F0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=K4jk56t/w4Lk3qy2PHfYxUb9LsNYE5qItmBwQ7gwB/Y=; b=BK0
	WlLIKO+aECrnbareA/8zll+lfMsHRqTWzpVWkMhN/FXcdLUDNaCieA+AdI0DDkXFhO/CXvq0UKENJ
	/QpxAnhDDL2NgbOuBLs6F1tZJsEDZYpfhVtYVenI89O1X/EtX00fQKszQMVYOSbIPZFGXCLWbPDSG
	PuC6/vjVucXXCcDCWkkjUzhy0ix8Et+HXST4umINBas7VBEPCVOhEANzSRYUuUbhbR+do8zQBFmU5
	+TyUWyS707FC5EOB6rjWzg+uH2wjprtkWRNDsqFRgzflmXdZdGzyxhLtXIj0F1yd6bnRZKrgD0yEJ
	OZ80Efn37nxYmI3/c9YAqh6PEXeneGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gitIN-0000gk-No; Mon, 14 Jan 2019 03:52:15 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gitIK-0000g3-IU
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 03:52:14 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Jan 2019 19:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,476,1539673200"; 
 d="gz'50?scan'50,208,50";a="125653642"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 13 Jan 2019 19:52:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gitIG-0004li-Bm; Mon, 14 Jan 2019 11:52:08 +0800
Date: Mon, 14 Jan 2019 11:51:08 +0800
From: kbuild test robot <lkp@intel.com>
To: Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [arm-platforms:arm64/spectre-sysfs 7/9]
 arch/arm64/kernel/cpu_errata.c:854:6: error: '__ssb_safe' undeclared; did
 you mean '__safe'?
Message-ID: <201901141127.PL5ZEhqo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_195212_635492_84D735C4 
X-CRM114-Status: UNSURE (   3.99  )
X-CRM114-Notice: Please train this message.
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kbuild-all@01.org,
 linux-arm-kernel@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git arm64/spectre-sysfs
head:   3c40035559ebdef0ca29c703d5e963a45c510851
commit: e2aefa70c8e57758618df743dcfd60c03a21f4b2 [7/9] arm64: enable generic CPU vulnerabilites support
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e2aefa70c8e57758618df743dcfd60c03a21f4b2
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/cpu_errata.c: In function 'cpu_show_spec_store_bypass':
>> arch/arm64/kernel/cpu_errata.c:854:6: error: '__ssb_safe' undeclared (first use in this function); did you mean '__safe'?
     if (__ssb_safe)
         ^~~~~~~~~~
         __safe
   arch/arm64/kernel/cpu_errata.c:854:6: note: each undeclared identifier is reported only once for each function it appears in

vim +854 arch/arm64/kernel/cpu_errata.c

80d44f9d Jeremy Linton 2019-01-09  833  
69cd443b Jeremy Linton 2019-01-09  834  ssize_t cpu_show_spec_store_bypass(struct device *dev,
69cd443b Jeremy Linton 2019-01-09  835  		struct device_attribute *attr, char *buf)
69cd443b Jeremy Linton 2019-01-09  836  {
69cd443b Jeremy Linton 2019-01-09  837  	/*
69cd443b Jeremy Linton 2019-01-09  838  	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
69cd443b Jeremy Linton 2019-01-09  839  	 *  for hetrogenous machines, and that if SSBS is supported its
69cd443b Jeremy Linton 2019-01-09  840  	 *  supported by all cores.
69cd443b Jeremy Linton 2019-01-09  841  	 */
69cd443b Jeremy Linton 2019-01-09  842  	switch (arm64_get_ssbd_state()) {
69cd443b Jeremy Linton 2019-01-09  843  	case ARM64_SSBD_MITIGATED:
69cd443b Jeremy Linton 2019-01-09  844  		return sprintf(buf, "Not affected\n");
69cd443b Jeremy Linton 2019-01-09  845  
69cd443b Jeremy Linton 2019-01-09  846  	case ARM64_SSBD_KERNEL:
69cd443b Jeremy Linton 2019-01-09  847  	case ARM64_SSBD_FORCE_ENABLE:
69cd443b Jeremy Linton 2019-01-09  848  		if (cpus_have_cap(ARM64_SSBS))
69cd443b Jeremy Linton 2019-01-09  849  			return sprintf(buf, "Not affected\n");
69cd443b Jeremy Linton 2019-01-09  850  		return sprintf(buf,
69cd443b Jeremy Linton 2019-01-09  851  			"Mitigation: Speculative Store Bypass disabled\n");
69cd443b Jeremy Linton 2019-01-09  852  	}
69cd443b Jeremy Linton 2019-01-09  853  
69cd443b Jeremy Linton 2019-01-09 @854  	if (__ssb_safe)
69cd443b Jeremy Linton 2019-01-09  855  		return sprintf(buf, "Not affected\n");
69cd443b Jeremy Linton 2019-01-09  856  
69cd443b Jeremy Linton 2019-01-09  857  	return sprintf(buf, "Vulnerable\n");
69cd443b Jeremy Linton 2019-01-09  858  }
69cd443b Jeremy Linton 2019-01-09  859  

:::::: The code at line 854 was first introduced by commit
:::::: 69cd443bc1874789fc016ec6d14f31b2951094ab arm64: add sysfs vulnerability show for speculative store bypass

:::::: TO: Jeremy Linton <jeremy.linton@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
JE1s/R8uhPnHo2YAAA==

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--IS0zKkzwUGydFO0o--

