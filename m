From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 8 Feb 2016 12:00:36 +0100
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <20160208105104.GA12991@leverpostej>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
 <20160208105104.GA12991@leverpostej>
Message-ID: <20160208110036.GC4117@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Feb 08, 2016 at 10:51:05AM +0000, Mark Rutland wrote:
> 
> > +	chosen {
> > +		stdout-path = "console0:115200n8";
> > +	};
> 
> There is no console0 alias, so this cannot work.
> 
> Did you mean serial0?

Oops... Yes, I meant serial0. I'll fix this.

> [...]
> 
> > +	aliases {
> > +		serial0 = &uart0;
> > +		serial1 = &uart1;
> > +		serial2 = &uart2;
> > +		serial3 = &uart3;
> > +	};
> 
> [...]
> 
> > +	psci {
> > +		compatible = "arm,psci-0.2", "arm,psci";
> > +		method = "smc";
> > +		cpu_on = <0x84000003>;
> > +	};
> 
> If you have PSCI 0.2, the cpu_on ID (and all other mandatory function
> IDs) are implicit.
> 
> If you want to have "arm,psci" as a fallback, then please add the IDs
> for functions mandatory in PSCI 0.2 which existed in the "arm,psci"
> binding. Otherwise, drop "arm,psci" from the compatible list, along
> with the cpu_on function ID.

OK. I'll make some tests and update.

Thanks or the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/98bcd677/attachment.sig>
