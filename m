From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 28 Jul 2014 05:31:43 +0000 (UTC)
Subject: [PATCH v2 2/2] ARM: DRA7: hwmod: Add dra74x and dra72x specific
 ocp interface lists
In-Reply-To: <1406523237-6905-3-git-send-email-lokeshvutla@ti.com>
References: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com>
 <1406523237-6905-3-git-send-email-lokeshvutla@ti.com>
Message-ID: <alpine.DEB.2.02.1407280530090.24161@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jul 2014, Lokesh Vutla wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> To deal with IPs which are specific to dra74x and dra72x, maintain seperate
> ocp interface lists, while keeping the common list for all common IPs.
> 
> Move USB OTG SS4 to dra74x only list since its unavailable in
> dra72x and is giving an abort during boot. The dra72x only list
> is empty for now and a placeholder for future hwmod additions which
> are specific to dra72x.
> 
> Fixes: d904b38df0db13 ("ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss")
> Reported-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>

Queued with a fix for the comment style - i.e.,

+       if (ois[0] == NULL) /* Empty list */

rather than 

+       if (ois[0] == NULL) /* Empty list*/

Please keep an eye out for this.


- Paul
