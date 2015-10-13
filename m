From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 16:31:02 +0200
Subject: [Resend: PATCH v2 1/4] Documentation: dt: soc: move driver
 description to a separate document
In-Reply-To: <1444679700-11451-1-git-send-email-m-karicheri2@ti.com>
References: <1444679700-11451-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <5224426.GUQgmoMZFj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 15:54:59 Murali Karicheri wrote:
> Currently the DT bindings have details about the driver as well. This
> patch moves this to a separate document for knav qmss driver so that
> driver detail update can be done as needed without polluting the DT
> bindings description.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  Documentation/arm/keystone/knav-qmss.txt           | 24 ++++++++++++++++++++++
>  .../bindings/soc/ti/keystone-navigator-qmss.txt    | 20 ++++--------------
>  2 files changed, 28 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/arm/keystone/knav-qmss.txt
> 
> diff --git a/Documentation/arm/keystone/knav-qmss.txt b/Documentation/arm/keystone/knav-qmss.txt
> new file mode 100644
> index 0000000..79946d1
> --- /dev/null
> +++ b/Documentation/arm/keystone/knav-qmss.txt
>  
> +For details of the driver, please refer to
> +Documentation/arm/keystone/knav-qmss.txt
>  
>  Required properties:
>  - compatible   : Must be "ti,keystone-navigator-qmss";
> 

I'd actually not even put this sentence in: the binding is supposed
to describe the hardware, not the Linux implementation as you correctly
describe above, but I'd also try to not reference files that only
exist in the Linux kernel tree.

	Arnd
