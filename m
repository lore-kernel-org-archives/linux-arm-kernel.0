From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Thu, 14 Feb 2013 09:12:10 +0100
Subject: [PATCH v4 4/8] watchdog/at91sam9_wdt: Adjust the options of
 watchdog_info
In-Reply-To: <20130213231522.GH7867@spo001.leaseweb.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
 <1359702386-21284-5-git-send-email-wenyou.yang@atmel.com>
 <20130213231522.GH7867@spo001.leaseweb.com>
Message-ID: <1459249.A0040oxoB3@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday 14 February 2013 00:15:22, Wim Van Sebroeck wrote:
> Hi Wenyou,
> 
> > Since the Watchdog Timer Mode Register can be only written only once,
> > so the watchdog_info shall not support WDIOF_SETTIMEOUT
> > and WDIOF_MAGICCLOSE options, remove them.
> 
> Ik you keep using the timer, then you don't have to remove this.

Why removing especially WDIOF_MAGICCLOSE (and the timer needed for that)? This is a feature removal. Without there isn't even a need for nowayout option as it is implicitly set anyway.
Nevertheless I would prefere keeping the timer to allow a user to let the kernel triggering the timer upon MAGICCLOSE.

Alexander
