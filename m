From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 28 Oct 2016 12:39:37 +0200
Subject: [PATCH] drm/mediatek: fix null pointer dereference
In-Reply-To: <1477643686.17640.3.camel@mtksdaap41>
References: <20161026140904.26798-1-matthias.bgg@gmail.com>
 <1477643686.17640.3.camel@mtksdaap41>
Message-ID: <87c18360-467c-267b-1400-48d985ecdc8a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/28/2016 10:34 AM, CK Hu wrote:
> Hi, Matthias:
>
> Even though OVL HW would not be enabled before component_add() in
> current design, your patch would be safe for any situation.

Maybe the FW I use left an interrupt pending before loading the kernel 
and this leads to the case where we enter the handler before all data 
structures are set up.

>
> Acked-by CK Hu <ck.hu@mediatek.com>

Thanks!

Matthias
