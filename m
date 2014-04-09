From: bp@alien8.de (Borislav Petkov)
Date: Wed, 9 Apr 2014 19:47:01 +0200
Subject: [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
In-Reply-To: <CAHLkNHJTA5bGD1zAfzE2JrDFAWvmgYyYjir+4vR-d9Fe2-E48g@mail.gmail.com>
References: <1393770760-32550-1-git-send-email-punnaia@xilinx.com>
 <a1a9e47a-069c-4285-9899-d5a58cf532c2@CO9EHSMHS003.ehs.local>
 <20140409113246.GA8778@pd.tnic>
 <CAL_Jsq+gszc+R_BrLtHKEBGYd=3T+sE1d+-HoF9aYZt6C2k5-g@mail.gmail.com>
 <20140409151932.GK6529@pd.tnic>
 <CAHLkNHJTA5bGD1zAfzE2JrDFAWvmgYyYjir+4vR-d9Fe2-E48g@mail.gmail.com>
Message-ID: <20140409174701.GO6529@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 10:59:49PM +0530, Punnaiah Choudary wrote:
> There is a driver file cache-l2x0.c under arch/arm/mm for pl310 cache
> configuration and management. Russel king had suggested to use
> single driver file for both pl310 edac implementation and cache-l2x0.c
> Here is the thread
> http://www.spinics.net/lists/arm-kernel/msg320407.html
> 
> please provide your inputs

Well, it is very simple - you don't really need an EDAC compilation unit
just so that you can report errors - you can very well do that in your
cache-l2x0.c and boom, problem solved.

Simply move the irq handler and the parity error checker to that file.

:-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
