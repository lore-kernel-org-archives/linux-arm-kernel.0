From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 1 Feb 2018 14:44:10 +0300
Subject: [PATCH 2/3] arm64: dts: renesas: eagle: Remove renesas,
 no-ether-link property
In-Reply-To: <20180115084125.8112-3-horms+renesas@verge.net.au>
References: <20180115084125.8112-1-horms+renesas@verge.net.au>
 <20180115084125.8112-3-horms+renesas@verge.net.au>
Message-ID: <05026363-9ae6-cd3b-15fe-4b9d8320cd6f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2018 11:41 AM, Simon Horman wrote:

> Regarding Salvator-X and ULCB boards, Bogdan Mirea says:
> 
>     The present change is a bug fix for AVB link iteratively up/down.
> 
>     Steps to reproduce:
>     - start AVB TX stream (Using aplay via MSE),
>     - disconnect+reconnect the eth cable,
>     - after a reconnection the eth connection goes iteratively up/down
>       without user interaction,
>     - this may heal after some seconds or even stay for minutes.
> 
>     As the documentation specifies, the "renesas,no-ether-link" option
>     should be used when a board does not provide a proper AVB_LINK signal.
>     There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
>     and ULCB starter kits since the AVB_LINK is correctly handled by HW.
> 
>     Choosing to keep or remove the "renesas,no-ether-link" option will
>     have impact on the code flow in the following ways:
>     - keeping this option enabled may lead to unexpected behavior since
>       the RX & TX are enabled/disabled directly from adjust_link function
>       without any HW interrogation,
>     - removing this option, the RX & TX will only be enabled/disabled after
>       HW interrogation. The HW check is made through the LMON pin in PSR
>       register which specifies AVB_LINK signal value (0 - at low level;
>       1 - at high level).
> 
>     In conclusion, the present change is also a safety improvement because
>     it removes the "renesas,no-ether-link" option leading to a proper way
>     of detecting the link state based on HW interrogation and not on
>     software heuristic.
> 
> On examination of the documentation for the Eagle board this change seems
> necessary as AVB_LINK is documented as being connected.
> 
> Fixes: 38525608952a ("arm64: dts: renesas: eagle: add EtherAVB support")
> Cc: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

   This one seems to work, or at least I can still mount NFS. :-)
   Couldn't do any other tests as the board is only available remotely...

MBR, Sergei
