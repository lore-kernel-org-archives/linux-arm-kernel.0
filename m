Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:54:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5697C214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cLby9uDL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXQZzrMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5697C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fjfwCp+VrI7YdeNCzlUczr4X9wjWCrvYMSWwTLv/UmA=; b=cLby9uDLkE+iC3
	K49drhh5RHHTotDIYuwYzumDC8XA/YZO65qRfys7e3S7+F1Rvw9ABtXfl5h2BF2IYCHouRXmKL9Un
	63s4Se2t3+zt49hYFrChEKBQiTuoHIjmDLDdhZfkv/8bJ/O8BJmZXMnAy19fINMMYoucYc/kZroyz
	RvGRoR7Qh4i/nZQRnw3oHnAuI0stdsYriFG71X8cLtneuGy2zRPwur5dGVB6urMnRKV3lnNpgMIk+
	chkkgMcw+l7KYEnFeymNv/P88YOCpgBlne3wOODxDOPTIHelebJHiQvgJLaT9ZnWMpgSw8oqgQnms
	x6N2jwrp2aIjIw+Uxz5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsWpt-0004da-22; Sat, 09 Feb 2019 17:54:41 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsWpp-0004cr-G9; Sat, 09 Feb 2019 17:54:39 +0000
Received: by mail-pg1-x529.google.com with SMTP id z10so2980954pgp.7;
 Sat, 09 Feb 2019 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q3Om9mSM/dRlTYIp7O4bWjIHDDjEt7Q+X6ja7q7RFHo=;
 b=dXQZzrMA8nnogMdhtttJf9xHtFWlz94HpvQgjSjjD2Wsz9MNsE9O85h2wl16ulX50o
 cte11T6Z0QJJ+ktm8diYlXTn3947q0Rjzm8s1L67SLkT5PUMVahCRvjlj1kKHBb/0e8c
 3T6wQoBEpZrmN7+hxT1/TX8x5Xru668i4ikxdBtyuaxoXBHIkqF7yDsSlDfllNjtD11/
 IFl6gMLI3k11x/y82DfdI5e7hqkLUNDAVPjxpukBGX/VJB5IWZd1cXvy8GiEDSgojmuY
 yNo3Px6YVOSWzUh1vS86fvmfLqrLQZdA10OX86GyuFVLpZRHP2Mby2C7rcUI6RXn2vn4
 zSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q3Om9mSM/dRlTYIp7O4bWjIHDDjEt7Q+X6ja7q7RFHo=;
 b=m85FdAUK3h5w0ODlHI2v1lGHMAyBSJ7zrrjngQZgfUtzbbT7ZYIDA5OsUayLsge/WT
 VLgxvQz6dk3Oto9gT9AaxTZMzPEKlqduobV1UrhBf0ma8pJR+Ylxynd4OcuJu1dJuloC
 0xuaK6l5AKNpl2VQCde8GNGPvVy6Bq7X7q8ClJTY6dh1B7kAzGFzWb0FydQWbeS8kwax
 +gUL69ZPo1td/1aRehsCTUpV39gnbxUZzGzbGhVS1ntwonLMo5mLx0vm6O2jsVx72Smm
 pDaBPTo7TiC8EFi9kWS05mSgATvmSAcVnIo+gdBJXze8OktAEx43iKc6eM1/2eHG0YHQ
 lu0Q==
X-Gm-Message-State: AHQUAuZYR1AUspY5Om5Sm+21sVKnTEwX0pLGHLf6KyOVHCIvk3l9hvcU
 RLmzsUqi7gD/MY07dh2Bj3o=
X-Google-Smtp-Source: AHgI3IYo9ZVTxNHxiWKKocF7wicWuUHvsl9abFMFGFPZhy1G1ez8T9B7VeW9fbHkb6kfI/bb2k6fNQ==
X-Received: by 2002:a63:2706:: with SMTP id n6mr10307040pgn.352.1549734875550; 
 Sat, 09 Feb 2019 09:54:35 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.181])
 by smtp.gmail.com with ESMTPSA id e9sm26359780pfh.42.2019.02.09.09.54.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 09 Feb 2019 09:54:34 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Subject: [PATCHv2 0/1] PATCHv2 Odroid c1+ usb fixes
Date: Sat,  9 Feb 2019 17:54:27 +0000
Message-Id: <20190209175428.1199-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_095437_556148_3FCDFCFC 
X-CRM114-Status: UNSURE (   7.81  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From my side this changes fix the usb power issue on usb1 ports
This is follow up on my previous patches.

Changes from prevoius patch drop the initialization of usb0 otg port.

RFC 
[0] https://patchwork.kernel.org/patch/10777359/
[1] https://patchwork.kernel.org/patch/10777369/

Patch v0
[0] https://lore.kernel.org/patchwork/patch/1031616/
[1] https://lore.kernel.org/patchwork/patch/1031617/

As per Martin's suggestion and input I have tried to fix below issue.

Fixed the phy power issue on the usb port.

# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  4    3      0 unknown     0mV     0mA     0mV     0mV
    c90c0000.usb                  1                                 0mA     0mV     0mV
    c90c0000.usb                  1                                 0mA     0mV     0mV
    VCCK                          1    1      0 unknown   860mV     0mA   860mV  1140mV
       cpu0                       0                                 0mA   860mV   860mV
 P5V0                             3    4      0 unknown  5000mV     0mA  5000mV  5000mV
    VCC1V8                        1    1      0 unknown  1800mV     0mA  1800mV  1800mV
       c1108680.adc               1                                 0mA     0mV     0mV
    VCC3V3                        1    2      0 unknown  3300mV     0mA  3300mV  3300mV
       VDD_RTC                    0    0      0 unknown   900mV     0mA   900mV   900mV
       TFLASH_VDD                 1    1      0 unknown  3300mV     0mA  3300mV  3300mV
          c1108c20.mmc:slot@1     1                                 0mA  3300mV  3400mV
    DDR_VDDC                      0    0      0 unknown  1500mV     0mA  1500mV  1500mV
    USB_VBUS                      2    1      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c1108820.phy.0         2                                 0mA     0mV     0mV
 TF_IO                            0    1      0 unknown  3300mV     0mA  1800mV  3300mV

# lsusb -t
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 3: Dev 5, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 5, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 5, If 2, Class=Audio, Driver=snd-usb-audio, 480M
        |__ Port 3: Dev 5, If 3, Class=Audio, Driver=snd-usb-audio, 480M
        |__ Port 4: Dev 6, If 0, Class=Mass Storage, Driver=usb-storage, 480M

 
Now hotpluing of usb device is working on odroid c1+ boards.
TODO: need to initialize the otg usb port to accept usb device.

Any input are welcome 

Best Regards
-Anand

Anand Moon (1):
  ARM: dts: meson8b: odroidc1: fix USB power supplies for phy

 arch/arm/boot/dts/meson8b-odroidc1.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
