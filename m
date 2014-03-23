From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 23 Mar 2014 01:42:03 +0100
Subject: [PATCH 17/62] ARM: ixp4xx: fix gpio rework
In-Reply-To: <1395257399-359545-18-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Wed, 19 Mar 2014 20:29:14 +0100")
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-18-git-send-email-arnd@arndb.de>
Message-ID: <m3y501hhk4.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Commit 098e30f6558f8 "ARM: ixp4xx: stop broadcasting the custom GPIO API"
> changed the internal gpio code of ixp4xx to be accessible only from
> common.c, but unfortunately that broke the Goramo MultiLink code, which
> uses this API.
>
> This tries to restore the previous state without exposing the
> API globally again. A better solution might be needed.

I think making the changes similar to those done to other IXP4xx
platforms is, indeed, preferred. Patch posted.
-- 
Krzysztof Halasa
