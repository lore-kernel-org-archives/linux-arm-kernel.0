Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE44C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6B820839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r5D0hWWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dyuaQS9d7y5Fd+fIRlbLU8dKVQFeeeb2lXLHiISIprE=; b=r5D0hWWaGTK4cO
	/Z9OPgTYT6TlhzyiLuDucqD2zCyrSV/9IB0O7uwoZsJX03yFWwY6fc8eEh4s+nr4nBkD/OE4RmJ/j
	vGwVLmh9GQab0Iqzw9nU2Ny3h3c+lRNIDIG2C7FfKmgrKPbl3EtA9J2yskOoP5aHDJ59pJmJsyprr
	t1WK6Hp2fv3yiCchi2S/sfXEPnZESc5IMQXZZPo2K8VkaaDrA++8KuMskzh7QtGVc9B2yVeEV1cPp
	pDXS4lfVQrvQ/5a10TSWFHPL0QQD+Xbg9r0r3zjy+khFsjgQOpGvU6Oqf/nNjpIV/LSrINwbN61p0
	5ZDa/+X491xhe5w0zMfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWu9Q-00012P-CC; Wed, 12 Dec 2018 02:21:28 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWu9N-00011L-9v; Wed, 12 Dec 2018 02:21:26 +0000
Received: by mail-oi1-f195.google.com with SMTP id y1so12024075oie.12;
 Tue, 11 Dec 2018 18:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hzI/A0LY6wZYrVXrit/7ykfGzVkCjWR3jJLQbnY6hpY=;
 b=nOOd1EtIzVdRvTV8ztTObJ/OtfeMMyb1C/ATlHB07idq+BGHHNBSgr1DX9t4SBdxzf
 XF5e6kzExTrsePne77HWFJSVtBB8Ok7k4291WqOsndqSSkmflkoNiBSIYwCNswR7n5Ss
 RrGF1q+/rKhObu4eZ+Q74B3k/B7fG9toJjEkxS/rB/aGnuysym9Sh8orSqapY329BHp2
 YBRCP42SLS+utdZ4EL9iEzvmiTjx15dvgXNXLGsMOaZfV54cOdFw4bslnlY3UKRH6Un0
 32bk3aUZCnvYl6Ut/qFn8HncWSwJKppBD8stuMScnNAcgLMvwzMzpE9mynt5KTPsNQ/+
 uxlQ==
X-Gm-Message-State: AA+aEWaPf8moiAH72l5ONSsdDdyxY30Z7pJ2QAScBPsy43eHTiF9z862
 gNylFT67e5ELDIpRplVvVA==
X-Google-Smtp-Source: AFSGD/VGNw9r88AezUNEN++9+TeS54AK7bit3QfXkyLPYhrqXrOhBwW/H6MvehDnUDy05XJW/xFpQw==
X-Received: by 2002:aca:b388:: with SMTP id c130mr177489oif.123.1544581274202; 
 Tue, 11 Dec 2018 18:21:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id e81sm7036415oig.8.2018.12.11.18.21.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 18:21:13 -0800 (PST)
Date: Tue, 11 Dec 2018 20:21:12 -0600
From: Rob Herring <robh@kernel.org>
To: Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
Message-ID: <20181212022112.GA14213@bogus>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
 <20181203165521.GB17883@e107155-lin>
 <f902086b-09e1-ad85-d191-137708f5b105@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f902086b-09e1-ad85-d191-137708f5b105@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_182125_344918_54658B37 
X-CRM114-Status: GOOD (  21.63  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Dmitriy Cherkasov <dmitriy@oss-tech.org>, Anup Patel <anup@brainfault.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Palmer Dabbelt <palmer@sifive.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 09:23:42AM -0800, Atish Patra wrote:
> On 12/3/18 8:55 AM, Sudeep Holla wrote:
> > On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
> > > cpu-map binding can be used to described cpu topology for both
> > > RISC-V & ARM. It makes more sense to move the binding to document
> > > to a common place.
> > > 
> > > The relevant discussion can be found here.
> > > https://lkml.org/lkml/2018/11/6/19
> > > 
> > 
> > Looks good to me apart from a minor query below in the example.
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >   .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
> > >   1 file changed, 67 insertions(+), 14 deletions(-)
> > >   rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > > similarity index 86%
> > > rename from Documentation/devicetree/bindings/arm/topology.txt
> > > rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > > index 66848355..1de6fbce 100644
> > > --- a/Documentation/devicetree/bindings/arm/topology.txt
> > > +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > 
> > [...]
> > 
> > > +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
> > > +
> > > +cpus {
> > > +	#address-cells = <2>;
> > > +	#size-cells = <2>;
> > > +	compatible = "sifive,fu540g", "sifive,fu500";
> > > +	model = "sifive,hifive-unleashed-a00";
> > > +
> > > +	...
> > > +
> > > +	cpu-map {
> > > +		cluster0 {
> > > +			core0 {
> > > +				cpu = <&L12>;
> > > +		 	};
> > > +			core1 {
> > > +				cpu = <&L15>;
> > > +			};
> > > +			core2 {
> > > +				cpu0 = <&L18>;
> > > +			};
> > > +			core3 {
> > > +				cpu0 = <&L21>;
> > > +			};
> > > +		};
> > > + 	};
> > > +
> > > +	L12: cpu@1 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x1>;
> > > +	}
> > > +
> > > +	L15: cpu@2 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x2>;
> > > +	}
> > > +	L18: cpu@3 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x3>;
> > > +	}
> > > +	L21: cpu@4 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x4>;
> > > +	}
> > > +};
> > 
> > The labels for the CPUs drew my attention. Is it intentionally random
> > (or even specific) or just chosen to show anything can be used as labels ?
> 
> SiFive generates the device tree from RTL directly. So I am not sure if they
> assign random numbers or a particular algorithm chooses the label. I tried
> to put the exact ones that is available publicly.
> 
> https://github.com/riscv/riscv-device-tree-doc/blob/master/examples/sifive-hifive_unleashed-microsemi.dts

Oh, that's really terrible. I wouldn't care as this was just source 
level stuff, but labels are part of the ABI with overlays.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
