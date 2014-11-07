From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Nov 2014 21:57:45 -0500
Subject: [PATCHv2 3/3] ARM: mvebu: add missing of_node_put() call in
 coherency.c
In-Reply-To: <1414423955-5933-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414423955-5933-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414423955-5933-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141107025745.GA3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:32:35PM +0100, Thomas Petazzoni wrote:
> There is a missing of_node_put() to decrement the device_node
> reference counter after a of_find_matching_node() in coherency_init().
> 
> Fixes: 501f928e0097 ("ARM: mvebu: add a coherency_available() call")
> Cc: <stable@vger.kernel.org> # v3.16+
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/fixes with Gregory's Ack.  Thanks for doing the Fixes
and stable tags!

thx,

Jason.
