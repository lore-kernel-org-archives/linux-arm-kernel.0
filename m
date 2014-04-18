From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Apr 2014 15:44:23 -0700
Subject: [PATCH 1/4] ARM: dts: Add support for OMAP4 Variscite OM44 family
In-Reply-To: <CAGhQ9VyFU0ee3nXmD3Ckpaj1wYfgWXWG1k=L16MYCX05sCtjOA@mail.gmail.com>
References: <1397833849-22396-1-git-send-email-manabian@gmail.com>
 <1397833849-22396-2-git-send-email-manabian@gmail.com>
 <20140418155721.GC5354@atomide.com>
 <CAGhQ9VysdxGMd99CiVVh8YJt7KDAyy3Pe9YA2VM-G4mzn_6+0g@mail.gmail.com>
 <20140418172907.GK5354@atomide.com>
 <CAGhQ9VyFU0ee3nXmD3Ckpaj1wYfgWXWG1k=L16MYCX05sCtjOA@mail.gmail.com>
Message-ID: <20140418224423.GN21823@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joachim Eastwood <manabian@gmail.com> [140418 11:04]:
> 
> > I did a check script when we split omap3 pinctrl core instance into
> > two separate instance to deal with the large hole in the register
> > space. Some parts of that might be usable for a generic conversion
> > script too. The script I used is below for reference.
> 
> I hacked up a short awk-script for the job. So I'll change to IOPAD
> macro's in the next version.
> 
> My script for reference :)
> #!/bin/gawk -f
> /omap4_pmx_core/ { pmx = "CORE" }
> /omap4_pmx_wkup/ { pmx = "WKUP" }
> /0x[0-9a-f]{1,3} \(PIN/ {
> offset = sprintf("OMAP4_%s_IOPAD(0x%03x, ", pmx, strtonum($1) + 64)
> sub(/0x[0-9a-f]{1,3} \(/, offset, $0)
> print $0
> next
> }
> { print $0 }

Cool script :)

Tony
