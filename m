From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 10 Aug 2017 08:12:52 +0000
Subject: [PATCH] ARM:dts:armadillo800eva: Add console parametters
In-Reply-To: <CAABR9nHUuSw7m6BCBxDs28YtppHxwHNQR5f06H0n8xcXKx7gCw@mail.gmail.com>
References: <1502027702-4366-1-git-send-email-phucduc.bui@gmail.com>
 <1502027702-4366-2-git-send-email-phucduc.bui@gmail.com>
 <20170807075920.GD7175@verge.net.au>
 <CAABR9nHUuSw7m6BCBxDs28YtppHxwHNQR5f06H0n8xcXKx7gCw@mail.gmail.com>
Message-ID: <87o9rnyhhh.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

>     >       chosen {
>     > -             bootargs = "earlyprintk ignore_loglevel root=/dev/nfs ip=dhcp rw";
>     > +             bootargs = "console=tty0 console=ttySC0,115200 earlyprintk
>     > +                             ignore_loglevel root=/dev/nfs ip=dhcp rw";
>     >               stdout-path = "serial0:115200n8";
>     >       };
>    
>     Hi,
>    
>     this feels wrong. My understanding is that stdout-path should be enough
>     to get the console.
(snip)
> Thank you for your comment.
> Before creating this patch, I have a patch reference of you and Geert.
> https://patchwork.kernel.org/patch/5184001/

I think he want to say here is that it needs "console=" which
is indicated by Geert on https://patchwork.kernel.org/patch/5184001/

	"Note that we have to keep the "console=ttySC1" parameter in
	chosen/bootargs, ..."

I don't have armadillo800eva anymore, so I can't test this patch.
But according to Phuc-san, there is not command prompt after boot
without this patch.

Best regards
---
Kuninori Morimoto
