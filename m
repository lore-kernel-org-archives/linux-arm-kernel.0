From: davem@davemloft.net (David Miller)
Date: Wed, 09 Nov 2011 16:11:34 -0500 (EST)
Subject: [PATCH] iMX28 Ethernet driver fix
In-Reply-To: <20111109124411.GA31046@axolotl.localnet>
References: <20111109124411.GA31046@axolotl.localnet>
Message-ID: <20111109.161134.468360904095628089.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Horton <phorton@bitbox.co.uk>
Date: Wed, 9 Nov 2011 12:44:11 +0000

> -	if (((unsigned long) bufaddr) & FEC_ALIGNMENT) {
> +	if ((((unsigned long) bufaddr) & FEC_ALIGNMENT) ||
> +		((id_entry->driver_data & FEC_QUIRK_SWAP_FRAME) &&
> +		skb_cloned(skb)))
> +	{

Please format this condition properly:

	if (A ||
	    (B &&
             C)) {
