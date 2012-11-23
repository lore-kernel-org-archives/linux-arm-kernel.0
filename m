From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Fri, 23 Nov 2012 12:06:44 +0100
Subject: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <50AF5610.7010505@gmail.com> (Daniel Mack's message of "Fri, 23
 Nov 2012 11:55:12 +0100")
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
 <1353338956-19420-4-git-send-email-zonque@gmail.com>
 <87zk2djox6.fsf@dell.be.48ers.dk> <50AF51AF.4050003@gmail.com>
 <87vccwegu2.fsf@dell.be.48ers.dk> <50AF5610.7010505@gmail.com>
Message-ID: <87r4nkefy3.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:

Hi,

 >> The other comment was about hw-romcode not being a very good
 >> name, as it apparently means the 1bit hamming code and ECC layout used
 >> on the older omap3, and not E.G. the bch8/elm layout used by
 >> E.G. am335x.

 Daniel> So which name would you pick? "bch1"?

No, it's hamming code, isn't it? To me it seems similar to the elm
discussion, E.G. we have a mix of ECC algorithm + ECC layout + use of hw
acceleration or not.

The choice of hardware acceleration or not should preferably be
transparent to this binding (E.G. it is purely an optimization, ECC
strength/format shouldn't change), so the driver should be free to
use it if it is available.


 Daniel> Thanks for the feedback - I'd also like to get these bindings
 Daniel> right in the first place.

Me too!

-- 
Bye, Peter Korsgaard
