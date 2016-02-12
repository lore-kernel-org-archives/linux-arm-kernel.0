From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 22:52:10 +0100
Subject: [PATCH] branch tracer: fix freak link error
In-Reply-To: <3016048.Uym15Ei2Bs@wuerfel>
References: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602121639340.13632@knanqh.ubzr>
 <3016048.Uym15Ei2Bs@wuerfel>
Message-ID: <6132207.AQ6oOdTfsj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 February 2016 22:49:07 Arnd Bergmann wrote:
> Now I have to check if it does anything to the spurious "maybe-uninitialized"
> warnings that I saw creeping in with PROFILE_ALL_BRANCHES. My guess is
> that it doesn't fix them (I submitted a patch to turn off those
> warnings today when PROFILE_ALL_BRANCHES is set), but I'll try anyway. 

Ok, that was easy: they are all still there, so we still need to
pass -Wno-maybe-uninitialized when using PROFILE_ALL_BRANCHES to
avoid flooding the log with useless warnings.

	Arnd
