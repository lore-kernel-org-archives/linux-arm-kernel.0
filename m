From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 18 Apr 2012 12:26:29 +0200
Subject: [PATCH 1/1] dt: Add general DMA window parser
In-Reply-To: <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
References: <201204180731.54064.arnd@arndb.de>
 <20120418.121824.1894043789811063795.hdoyu@nvidia.com>
 <20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
 <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
Message-ID: <20120418102629.GA14533@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiroshi Doyu wrote:
> +	cells = prop ? *(__be32 *)prop : of_n_addr_cells(dn);

I think this needs to be:

	cells = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);

Only casting isn't enough, you need the bytes to be swapped.

> +	cells = prop ? *(__be32 *)prop : of_n_size_cells(dn);

Similarly:

	cells = prop ? be32_to_cpup(prop) : of_n_size_cells(dn);

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/d8de2877/attachment.sig>
