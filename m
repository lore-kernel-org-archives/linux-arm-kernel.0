From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 20:34:14 +0200
Subject: [PATCH] PCI: mvebu: Fix uninitialized variable in
 mvebu_get_tgt_attr()
In-Reply-To: <20140905202044.4c166a43@free-electrons.com>
References: <1407512045-26969-1-git-send-email-geert+renesas@glider.be>
 <20140905174122.GD8080@google.com>
 <20140905202044.4c166a43@free-electrons.com>
Message-ID: <5898856.RmRf87KNto@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 20:20:44 Thomas Petazzoni wrote:
> Hum, I think I would actually prefer something like:
> 
>                 if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
>                         rtype = IORESOURCE_IO;
>                 else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
>                         rtype = IORESOURCE_MEM;
> +               else
> +                       continue;
> 
> So that we're explicit with the fact that we only care about I/O and
> MEM32 resource types.

Agreed, that looks better than my patch as well.

	Arnd
