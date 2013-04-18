From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 12:48:36 +0200
Subject: [PATCH 07/32] ARM: ux500: Supply address location names for the
 DMA40 DMA controller
In-Reply-To: <1366279934-30761-8-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-8-git-send-email-lee.jones@linaro.org>
Message-ID: <201304181248.36597.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> The DMA40 controller uses two sets of base addresses. In order to have
> them automatically setup as resources by the Open Format framework we
> have to set names for them. The names have to be the same as the ones
> used to fetch them back out of the resource structure.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Typo: s/Open Format/Open Firmware/

To be more specific, just write of_platform framework. Note that we
still get resources without passing the names, they are just not
named in that case and have to be retrieved by index.

You should also document the strings in the binding document.

	ARnd
