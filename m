From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 4 Jul 2016 18:02:03 +0200
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2: add ETM, ETB and ETMCK node
In-Reply-To: <CALdGsk+rSYukvo6-zqgqNTwJnf8QXu2bCSAdurpg1=BVtENZvw@mail.gmail.com>
References: <1467383831-6985-1-git-send-email-olivier.schonken@gmail.com>
 <1467383831-6985-2-git-send-email-olivier.schonken@gmail.com>
 <20160701183248.GC2874@piout.net>
 <CALdGsk+KwPMVKXhKtcmoUFqfj6aQRvQSY74F31fSvZhV+QvjAA@mail.gmail.com>
 <20160702204608.257b8bc6@bbrezillon>
 <CALdGsk+RO_cxfcTLVyKHP3aVMkSTtzEzQXz2G4ARX7vqxRazSA@mail.gmail.com>
 <20160704110018.76288816@bbrezillon>
 <CALdGsk+rSYukvo6-zqgqNTwJnf8QXu2bCSAdurpg1=BVtENZvw@mail.gmail.com>
Message-ID: <20160704160203.GJ20045@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2016 at 11:08:42 +0200, Olivier Schonken wrote :
> That is the dilemma I face with the structure.  What is the least
> invasive option to include the coresight functionality, without
> breaking the amba probe for other architectures that rely on it having
> a clock to enable/disable, and not break the processor startup by
> messing with stable clocks for the sake of giving the ETB/ETM a clock
> it doesn't need.
> That is why in the end I decided on a dummy clock driver.  To keep
> with the convention of having a clock specific to the ETM, and leaving
> the rest of the clocks as is.
> 

Well, the issue is in the pit driver, see the patch I just sent. With
both of your patches, I got my sama5d2 xplained botting fine.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
