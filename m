From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 19:57:43 -0600
Subject: [PATCH v4 1/2] dt-bindings: usb: ehci: add optional external
 vbus supply property
In-Reply-To: <1519897899-8577-2-git-send-email-amelie.delaunay@st.com>
References: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
 <1519897899-8577-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <20180306015743.uazy4e5quil2ijy2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 10:51:38AM +0100, Amelie Delaunay wrote:
> On some boards, especially when vbus supply requires large current,
> and the charge pump on the PHY isn't enough, an external vbus power switch
> per port may be used.
> Add portN_vbus-supply property to usb-ehci bindings. As the number of ports
> depends on the ehci controller, and the port on which an external vbus
> supply depends on the platform, <portN> is used to make it generic.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 3efde12..cd576db 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - phys : phandle + phy specifier pair
>   - phy-names : "usb"
>   - resets : phandle + reset specifier pair
> + - portN_vbus-supply : phandle of regulator supplying vbus for port N

Just make this an array with the index being the port (and drop 
"portN_").

Rob
