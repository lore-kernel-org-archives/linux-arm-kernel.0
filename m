Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8596C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:02:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B2420842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M7p0uUV2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="SEG2klxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B2420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7C6nASCGTX8JwmfJjuyg+lyCHuqozZaz9dUY9CvpGZY=; b=M7p0uUV2my1FEB
	4Zhip7pVBOXaS+hnReMCk2KmDr5y+Nq+rmeRL9K40/12lbSiNMmmK4Vh9n4Md5faD5IvdO4hdJ4+A
	9tTa+n3G31wUaZ5OhXgche5d8OsHJgMZciQee8AhbHWUxfJIpKunl0O7JGsnMnMWhMhCv+1aVTpBp
	5g4RoucgDKrE2hmVFOmmkq3ioi3WAx0f/lb+xHrrVB4T3R6+W2joyYAk4gavBTt2xkphvy4KSJ8Ko
	cP4TE24KhxRZ+P9+63vBknIgVMY26IxB/IUPdbDPBt9C+fYvWI660Pn8WxX0HI29sTwo7tyskxddF
	f2Mf7A4Uc8d3fWDjn3og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVq0-0006u3-Is; Tue, 12 Feb 2019 11:02:52 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVpt-0006sf-Bx
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:02:50 +0000
Received: by mail-yb1-xb42.google.com with SMTP id x13so850851ybm.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ettus-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1TQumLme3VslgLidIYqA5/lXkSqNK175qjGod6Gj/HI=;
 b=SEG2klxAVYy3ShSSvEnQjvAi5binY5sJpnF1brUGgZaRCWfmXlmt7tuHBEPUR/5GuP
 HTltwY1qZU+5O5IOCOpgkF1ssKDIH8RoggYP249RiUDzD0gqasf7MLm831mK9rtkIb9E
 cCz7sx1QKqWMrUgUtFyIrcFapMhGqjMAd7h8AsKIPXXJ8cj5wb6QrcJeCtmGVajnBEdW
 qgi+uk+zUIIzZdYfKUL/6XRLz8DVPovVDLhJvMlBFwRxrNjyMuAxZRh5tGz8AMXmrA8+
 N8HqOgiZ/dcx1gS7SLGw8eX18LKhMYIfIrqeJvWmMjUIRx8Yavfs9fExdYrZt3Dx00vv
 6flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1TQumLme3VslgLidIYqA5/lXkSqNK175qjGod6Gj/HI=;
 b=MKfAB15HVd+gbOCMA907biO0Q3Bx1WhPORlMzwzwoTbiekmbBDQ3rtwFwr/CNymwih
 p4Udylya5fM9eRbVtKGyNDIT7N1efM9tkUazQ52t6rzXqkavrDiajOiAYNZWEIrNxcTe
 1oHXbFOjsq3KbAW+61eijjBAFF4MMgJCotVTICZuBZCClVpWk6UQ0GrbhNvDltLNOWXh
 vLkYt7t2tDcOl4i4kFo/fACPnZqdt+vYzJEkvJGmeQDKArdjQxWgZjxzaCJ+1mruroHs
 3FIjOvaFDXhwn1u/vc8NM21JsKuZEQm/q+Zhh0J877SR1eN1TC6KJlF/uByhdXLxkDVr
 JD6w==
X-Gm-Message-State: AHQUAuaFtECu1sldtnWa6I988lQtRQSnKBlKpKpPTtNCKSUjFWYGn9K7
 WQB60qQmgrWnyDL5vuq3TqKWdIpbAzeIikB66OykdA==
X-Google-Smtp-Source: AHgI3IYLJ4YuJVUaAx71HhbJwIAKrL39Z8uLVKZBQFNWT3iT4yLnfRiX4jolQ2bFJgGBNlYCEw2qTDDFsngcCijK1+4=
X-Received: by 2002:a25:7d05:: with SMTP id y5mr2250739ybc.439.1549969363078; 
 Tue, 12 Feb 2019 03:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20190211161736.23844-1-nava.manne@xilinx.com>
In-Reply-To: <20190211161736.23844-1-nava.manne@xilinx.com>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Tue, 12 Feb 2019 03:02:32 -0800
Message-ID: <CAAtXAHfUih0fWh6GhkRLKHb9epqhY_BnVzD-wBZ28rK+QY82LA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
To: Nava kishore Manne <nava.manne@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_030245_411312_D80D54EE 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Devicetree List <devicetree@vger.kernel.org>, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jolly Shah <jollys@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Nava,

a couple of nits inline. otherwise looks fine to me.

On Sun, Feb 10, 2019 at 8:17 AM Nava kishore Manne
<nava.manne@xilinx.com> wrote:
>
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
>                 -Created patches on top of 5.0-rc5.
>                  No functional changes.
> Changes for v2:
>                 -Removed "----" separators.
> Changes for v1:
>                 -Created a Seperate(New) DT binding file as
>                  suggested by Rob.
>
> Changes for RFC-V2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.
>
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 0000000..1f6f588
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,13 @@
> +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
> +using ZynqMP SoC firmware interface

How about:
Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.

> +For Bitstream configuration on ZynqMp Soc uses processor configuration
> +port(PCAP) to configure the programmable logic(PL) through PS by using
> +FW interface.
ZynqMP or ZynqMp, let's stay consistent here.

How about:
The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
Programmable Logic (PL). The configuration uses  the firmware interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +       zynqmp_pcap: pcap {
> +               compatible = "xlnx,zynqmp-pcap-fpga";
> +       };
> --
> 2.7.4
>

Thanks,
Moritz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
