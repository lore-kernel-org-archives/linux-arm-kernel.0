From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 12:01:40 +0100
Subject: [PATCH v11 6/8] arm64: renesas: add Salvator-X board support on
 DTS
In-Reply-To: <1444890243-6978-7-git-send-email-horms+renesas@verge.net.au>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-7-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20151015110139.GG8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/ {
> +	model = "Renesas Salvator-X board based on r8a7795";
> +	compatible = "renesas,salvator-x", "renesas,r8a7795";
> +
> +	aliases {
> +		serial0 = &scif2;
> +		serial1 = &scif1;
> +	};
> +
> +	chosen {
> +		bootargs = "ignore_loglevel";

Do we really need this kind of thing in the kernel DTs?

> +		stdout-path = &scif2;

No rate? It would be better to be explicit here; you should be able to
have:

	stdout-path = "serial0:115200n8"

Where "115200n8" is replaced with whatever configuration this board
actually has.

Thanks,
Mark.
