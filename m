From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 22 Jul 2013 18:30:43 +0100
Subject: [PATCH 07/11] ARM: shmobile: EMEV2 map_io update
In-Reply-To: <0ea2b5389ab1b63aa880c5735c15be0b26b91b1a.1374478037.git.horms+renesas@verge.net.au>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
 <0ea2b5389ab1b63aa880c5735c15be0b26b91b1a.1374478037.git.horms+renesas@verge.net.au>
Message-ID: <51ED6C43.5070404@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/13 08:36, Simon Horman wrote:
> From: Magnus Damm<damm@opensource.se>
>
> Update the EMEV2 struct map_desc to exclude the SMU
> and also include the ->map_io() callback in the DT
> version of EMEV2 board support.
>
> The EMEV2 SMP code can these days perform ioremap()
> early on without the SMU information in the io_desc[].
>
> To correctly support SMP in case of DT-only board
> support then the ->map_io() callback is needed.
>
> Signed-off-by: Magnus Damm<damm@opensource.se>
> Acked-by: Arnd Bergmann<arnd@arndb.de>
> Signed-off-by: Simon Horman<horms+renesas@verge.net.au>

This looks roughly what we did to get the the EMEV2 working
here, although ours is a little more hacky.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
