From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 24 Mar 2012 19:26:00 +0000
Subject: [PATCH V2 1/3] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <1332594876-8673-2-git-send-email-jm@lentin.co.uk>
References: <1332594876-8673-1-git-send-email-jm@lentin.co.uk>
 <1332594876-8673-2-git-send-email-jm@lentin.co.uk>
Message-ID: <201203241926.00597.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 March 2012, Jamie Lentin wrote:
> 
> Add support for the DNS-320 and DNS-325. Describe as much as currently possible
> in the devicetree files, create a board-dnskw.c for everything else.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

Looks good to me. 

Jason, do you want to add these to your tree? You are already have some
the patches for dreamplug, and I think it makes sense to update these two
together when you have more patches.

Since the dnskw board file contains mostly gpio setup, I think it would
be good if one of you could take that part on next: once the gpio controller
uses DT probing, you can move all the gpio leds and buttons into the
device tree, which drastically shrinks the dnskw file.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
