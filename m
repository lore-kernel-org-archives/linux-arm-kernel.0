From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 08:03:44 +0000
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <201112172026.34215.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
 <201112172026.34215.heiko@sntech.de>
Message-ID: <20111218080344.GQ14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 08:26:33PM +0100, Heiko St?bner wrote:
> +	release_resource(hsudc->mem_rsrc);
> +	kfree(hsudc->mem_rsrc);

release_mem_region() is paired with request_mem_region.  Do not go beneath
the API by doing the above.
