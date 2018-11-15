From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2018 17:45:33 +0000
Subject: [PATCH v4 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
In-Reply-To: <20181105225431.24485-5-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181105225431.24485-5-f.fainelli@gmail.com>
Message-ID: <20181115174532.GA3087@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 02:54:29PM -0800, Florian Fainelli wrote:
> ARM64 is the only architecture that re-defines
> __early_init_dt_declare_initrd() in order for that function to populate
> initrd_start/initrd_end with physical addresses instead of virtual
> addresses. Instead of having an override we can leverage
> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
> populate those variables for us.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/mm/init.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

Looks ok to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
