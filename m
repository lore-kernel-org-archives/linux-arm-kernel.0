From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 14 Apr 2016 16:31:25 +0200
Subject: [PATCH 3/6] ARM: PSCI: Register with kernel restart handler
In-Reply-To: <570F9942.30608@roeck-us.net>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
 <1460120039-2497-4-git-send-email-linux@roeck-us.net>
 <20160413110519.GE32018@leverpostej>
 <570E4550.5000207@roeck-us.net>
 <CAMuHMdU+vj4HDTLdXngUsTjF-Ki-HtbhoRU6mV7UKCz-BhFAtQ@mail.gmail.com>
 <20160414004223.GA18564@roeck-us.net>
 <20160414085242.GB1533@katana> <570F9942.30608@roeck-us.net>
Message-ID: <20160414143125.GB1539@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> "the higher, the more important" makes sense to me. We don't have to
> enforce the linux scheme, though that happens to be the same (the priority
> argument in the notifier block takes an int, so it would not even be
> necessary to adjust it unless someone specifies 0xffffffff).

I think we should enforce the scheme internally (but not in DT, of
course):

a) it is documented to be in the range 0-255
b) it should be valid to prioritize the watchdogs with 1,2,3 in DT.
   If we don't apply the '255 - pos_in_sorted_list' value, then the
   priority could be below some machine default of 128, or?

> I am fine either way - boolean properties or numbers, with a personal
> preference for numbers as more flexible.

Same here. Time to go to the DT list probably.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/bdba3a4d/attachment-0001.sig>
