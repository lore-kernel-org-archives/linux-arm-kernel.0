Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AEAC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:30:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F382070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JYS/AGKm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0a/odKRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F382070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ns+QtlDtkyDX1AhWmEN9wqMbPI+clFM7hvTi4hhAiw4=; b=JYS/AGKmgOpxAs
	2IRPVaFmsaX1xS3+Uk90N6sbbXbVU5xtuJUq18NsKM3A1K8+BmEhL+vFY1+NUzQFttvwJJr1EMmQd
	zd/j4nxN6GWq4dnOjTFTpqdSmeRPFZ0AkRdD9vkc4loCxkDdWP4W+YW9B+yTdilIMutqnMWbwkrAM
	cQulLVhkj5oSlioWTMk8cREszPMtzPQ4PVJWl0+UK2VXlOujfAGjKUVDkqY3Y5siqAQZwVes+ir4z
	wBY0nydsQocgnzW/0Biky63GKT+Ri+bh67Wga7Ljiw+F6jCcPwyvzRh5m7IuZvzY+bP5nEVaE30Zd
	Fkf+4FBmUk3a33GLPrAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxHTC-0002B4-Mu; Fri, 22 Feb 2019 20:30:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxHT9-0002Ag-7C
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 20:30:52 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50D77207E0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550867450;
 bh=7bLM5+3IQujF98X0zL8N6k213Vu2WBiNhmN2ZhN2wn4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0a/odKRCAEfajT0phPV6BkT7Egdgtv/TrdEu5463Gz4xuckzFiw2IO108Fs38K2ae
 8VSrPlcIfzLZXhF0jOYljDCrGUelFHRzqgIdFE7+q8ZuisL6tyQRz59zR2YbKlalfd
 nqheEZi/lECELl0vWMNzVFdv9NkcTfD+Zp6iJVso=
Received: by mail-qt1-f173.google.com with SMTP id w4so4064291qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 12:30:50 -0800 (PST)
X-Gm-Message-State: AHQUAuZbFD8aMcXrwePjFnzHZj5L30DMs2eRQRM3u+2/nVXBrdE5g9TJ
 IDQMwEi8q+mIC/76NDCqCUp6dAzx/6BT7Zo7wg==
X-Google-Smtp-Source: AHgI3Ib2ygTqf6/bY+f2UWbd+u3M2r8MVsTsfDmAWX6MvaBdPfE00UfFfdLsGD/MxmRGH5xMlXX6Ue3e9ZYRN82KZkA=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr4692215qtd.144.1550867449490; 
 Fri, 22 Feb 2019 12:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-7-nava.manne@xilinx.com>
 <20190121154928.GA32129@bogus>
 <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Feb 2019 14:30:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
Message-ID: <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
To: Nava kishore Manne <navam@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_123051_297873_C261776A 
X-CRM114-Status: GOOD (  22.89  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
 Michal Simek <michals@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 2:46 PM Nava kishore Manne <navam@xilinx.com> wrote:
>
> Hi Rob,
>
>
>
> Thanks for providing the comments...

Please fix your mailer to send plain text emails to mail lists.


> > -----Original Message-----
>
> > From: Rob Herring [mailto:robh@kernel.org]
>
> > Sent: Monday, January 21, 2019 9:19 PM
>
> > To: Nava kishore Manne <navam@xilinx.com>
>
> > Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
>
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
>
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
>
> > <JOLLYS@xilinx.com>; chinnikishore369@gmail.com
>
> > Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
>
> > driver
>
> >
>
> > On Mon, Jan 21, 2019 at 11:08:35PM +0530, Nava kishore Manne wrote:
>
> > > Add documentation to describe Xilinx ZynqMP fpga driver bindings.
>
> > >
>
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>
> > > ---
>
> > > Changes for v3:
>
> > >                         -Removed PCAP as a child node to the FW and Created
>
> > >                         an independent node since PCAP driver is a consumer
>
> > >                         not a provider.
>
> > >
>
> > >  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt         | 13 +++++++++++++
>
> > >  1 file changed, 13 insertions(+)
>
> > >  create mode 100644
>
> > > Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> > >
>
> > > diff --git
>
> > > a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> > > b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> > > new file mode 100644
>
> > > index 000000000000..1f6f58872311
>
> > > --- /dev/null
>
> > > +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> > > @@ -0,0 +1,13 @@
>
> > > +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC
>
> > > +controlled using ZynqMP SoC firmware interface For Bitstream
>
> > > +configuration on ZynqMp Soc uses processor configuration
>
> > > +port(PCAP) to configure the programmable logic(PL) through PS by
>
> > > +using FW interface.
>
> > > +
>
> > > +Required properties:
>
> > > +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
>
> > > +
>
> > > +Example:
>
> > > +      zynqmp_pcap: pcap {
>
> > > +                     compatible = "xlnx,zynqmp-pcap-fpga";
>
> > > +      };
>
> >
>
> > There's no need for a DT node. Just make the firware driver create a platform
>
> > device for pcap.
>
> >
>
>
>
> This driver being used by the FPGA manager framework(fpga-region) to apply overlay's so this node is needed AFAIK.

The binding says nothing about child nodes and what they are. Please
define that.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
