From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 6 Mar 2014 14:06:55 +0100
Subject: [PATCH V2 01/12] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <1434755.d9svPEINg5@avalon>
References: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
 <1394105552-9744-2-git-send-email-wsa@the-dreams.de>
 <1434755.d9svPEINg5@avalon>
Message-ID: <20140306130655.GA10657@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +  - clocks: References to possible parent clocks. Order must match clock
> > modes
> > +    in the datasheet.
> 
> I believe the order should be documented explicitly instead of referring to 
> the datasheet.

I wanted to keep it generic in case future SoCs want to use the driver.

> > +	num_clks = of_property_count_strings(np, "clock-output-names");
> > +	if (WARN(num_clks <= 0, "can't count CPG clocks\n"))
> > +		goto out;
> 
> You can return directly instead of goto out.

I personally don't prefer the mixture of goto and direct return. Please
say if you insist on that.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/2817bf52/attachment-0001.sig>
