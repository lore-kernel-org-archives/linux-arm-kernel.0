From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 12:22:34 +0100
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
Message-ID: <6859810.tb1t0IEONi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 February 2016 11:10:33 Linus Walleij wrote:
> 
> ERROR (duplicate_label): ERROR (duplicate_label): Duplicate label
> 'clcd_panel' on /panel at 1/port/endpoint and /panel at 0/port/endpoint
> Duplicate label 'clcd_panel' on /panel at 1/port/endpoint and
> /panel at 0/port/endpoint
> 
> So the dtc does not allow duplicate node labels for the phandle
> even if the node it resides in is disabled. Tough luck...

Ah, too bad. I guess we could still do it by also setting the
remote-endpoint property to node->phandle, but then it's
not as simple any more.

	Arnd
