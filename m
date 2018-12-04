Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076A2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCC820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kD1L1nfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCC820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qKTPxKCELCsIdt6MwYxH4Z3FVELyk84Ix/pCGty1sdY=; b=kD1L1nfRBB2cEJ
	bgFfNCHuOrY3gME+8z6oraPvUd6uKW5uPceRNkXbvOONz8Ljh6Je/Km7rR/KLNCYktMMIXegv2xWE
	F3WZ9XOpsGHaiaBQ+gcWzoqr9p9SMElO8HjtO6kh6fStxUoDnMg9mMK5DPtidgX089DvcKSFR0/eA
	V19Cvbh+bOQNv1oOj42y4EFloOgPAaHEhw8OhZudbwDbJTQs34yi8T1mIUO3TvRpqhWDawXwJ6JoA
	Sbegjbta9UCPh5Cgpr6dZF+mjm6inLPVTZJmz/iIwS8PkQA3IAv17kbad0zxNumUPUVrdGEu34Y49
	Ot626f4FF02ytRiQIZWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFZC-0007F9-A5; Tue, 04 Dec 2018 18:37:06 +0000
Received: from mail-oi1-f170.google.com ([209.85.167.170])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFZ8-0007DI-Bm
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:37:03 +0000
Received: by mail-oi1-f170.google.com with SMTP id v6so15190056oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 10:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=1eCyanNmw6RH5JyZyihWyMNvhbAh2kC02pg1oBqgzmU=;
 b=J/ybSlzmhAmvRkJXwcOEZGIo9a88egpXSso9GXZ8rXzYZy6vwW9hovhyeXzBY2WQGx
 G2yc0txFF1/E4UCt9yAkrbwmOvR1MKLP4sriQ2cpIM+xNhIX8QaHyH8JS+YzBF6Ywt9J
 6IWEWl3edOUxDfHluuODqkeVaFNhP55ec5EyuPm2bplR+l4mjzl5z3SWeYyu+X5audZ8
 xZWJZzOhxl9QDoRONElWsT355k3RsKD/Hk+ws/H4Bg3g6yd2tUUfHwmOHWdEW1ki5LDs
 4DnBN+OToUMYjQnXFD6fO38fc2RENlo8bXviECm1XYhahrAgIM81BpCts5hKYdnuvpQH
 r1rg==
X-Gm-Message-State: AA+aEWbywCdgpljm3V93ZIKIolvLTfI/3KMLFrHw8pc2L2QrUUdAq06I
 j383OVjm54b1vSTyMg45bA==
X-Google-Smtp-Source: AFSGD/Uzeppb4Ge89n17ZEmoeyEqcVJBzpKOUzjOGe8V+h/vbCJPvtmrhhuONYCqf5gpXnDxcVUKnw==
X-Received: by 2002:aca:1918:: with SMTP id l24mr12484774oii.236.1543948611267; 
 Tue, 04 Dec 2018 10:36:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l1sm13520026oib.10.2018.12.04.10.36.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 10:36:50 -0800 (PST)
Date: Tue, 4 Dec 2018 12:36:49 -0600
From: Rob Herring <robh@kernel.org>
To: arm@kernel.org
Subject: Moving ARM dts files
Message-ID: <20181204183649.GA5716@bogus>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_103702_402457_EE9F75B9 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>, linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Olof, Arnd,

I've put together a script to move the dts files and update the 
makefiles. It doesn't handle files not following a common prefix which 
isn't many and some includes within the dts files will need some fixups 
by hand.

MAINTAINERS will also need updating.

A few questions:

Do we want to move absolutely everything to subdirs? There's quite a 
few platforms with only 1-2 platforms. I haven't added these to the 
list yet, but can.

Do any vendors need another level of directories? davinci, omap, nspire, 
etc. for TI for example.

What to do with armv7m.dtsi? I guess it should remain and we just fixup 
the include. There may be a few other cross vendor things.


Sub-arch maintainers, 
'vendor_map' below is the mapping of file prefix to new subdirectory 
(the SoC vendor prefix). Please comment if there are any issues.

Rob

8<-----------------------------------------------------------
#!/usr/bin/env python3

import os
import re
from git import Git
import glob

vendor_map = {
    'imx': 'fsl',
    'ls': 'fsl',
    'vf': 'fsl',
    'qcom': 'qcom',
    'am3' : 'ti',
    'am4' : 'ti',
    'am5' : 'ti',
    'da' : 'ti',
    'dm' : 'ti',
    'dra' : 'ti',
    'keystone' : 'ti',
    'omap' : 'ti',
    'nspire' : 'ti',
    'armada' : 'marvell',
    'berlin' : 'marvell',
    'dove' : 'marvell',
    'kirkwood' : 'marvell',
    'orion' : 'marvell',
    'pxa' : 'marvell',
    'mvebu' : 'marvell',
    'mmp2' : 'marvell',
    'arm-' : 'arm',
    'integ' : 'arm',
    've' : 'arm',
    'aspeed' : 'aspeed',
    'at91' : 'atmel',
    'sama' : 'atmel',
    'bcm' : 'brcm',
    'exynos' : 'samsung',
    's3c' : 'samsung',
    's5p' : 'samsung',
    'gemini' : 'cortina',
    'hi3' : 'hisilicon',
    'hip' : 'hisilicon',
    'hisi' : 'hisilicon',
    'mt' : 'mediatek',
    'meson' : 'amlogic',
    'owl' : 'actions',
    'r7' : 'renesas',
    'r8' : 'renesas',
    'r9' : 'renesas',
    'rk' : 'rockchip',
    'socfpga' : 'altera',
    'st' : 'st',
    'spear' : 'st',
    'sun' : 'allwinner',
    'tegra' : 'nvidia',
    'zynq' : 'xilinx',
    'wm' : 'wm',
    'uniph' : 'socionext',
    'zx' : 'zte',
}

if __name__ == "__main__":
    g = Git('.')

    g.checkout("HEAD", "arch/arm/boot/dts/Makefile")
    dts_make = open("arch/arm/boot/dts/Makefile", "r").read()

    # make entries 1 line
    make2 = re.sub(r'\\\n', '', dts_make)

    for k,v in vendor_map.items():
        for f in glob.iglob("arch/arm/boot/dts/" + k + "*.*"):
            new_dir = "arch/arm/boot/dts/" + v + "/"
            base = os.path.splitext(os.path.basename(f))[0]

            os.makedirs(new_dir, exist_ok=True)
            g.mv(f, new_dir)

            # Remove the file from the makefile
            dts_make = re.sub('.*' + base + r'\.dtb.*\\\n', '', dts_make)
            dts_make = re.sub('.*' + base + r'\.dtb', '', dts_make)

            # extract the matching makefile entry
            reg = re.search(r'.*' + base + r'.*', make2)
            if not reg:
                continue

            entry = reg.group(0)
            make2 = re.sub(r'.*' + base + r'.*', '', make2)
            if entry:
                makefile = open(new_dir + 'Makefile', 'a+')
                print(entry, file=makefile)
                makefile.close()


    for d in sorted(glob.iglob("arch/arm/boot/dts/*/")):
        dts_make += 'subdir-y += ' + d.split(os.path.sep)[-2] + '\n'

        # Add license and sort entries of sub-dir makefile
        vendor_make = '# SPDX-License-Identifier: GPL-2.0\n'
        make_lines = open(d + 'Makefile', 'r').readlines()
        for l in sorted(make_lines):
            vendor_make += l

        vendor_make = re.sub(r'\t', r'\\\n\t', vendor_make)

        f = open(d + 'Makefile', 'w')
        f.write(vendor_make)
        f.close()
        g.add(d + 'Makefile')

    # Remove entries with no dtbs left
    dts_make = re.sub(r'.*\+= \\\n\n', '', dts_make)

    open("arch/arm/boot/dts/Makefile", "w").write(dts_make)
    g.add("arch/arm/boot/dts/Makefile")

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
