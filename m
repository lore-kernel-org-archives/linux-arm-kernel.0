From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 10:54:26 +0200
Subject: [PATCH v2 00/11] Aspeed AST2400 and AST2500 BMC support
In-Reply-To: <1461225849-28074-1-git-send-email-joel@jms.id.au>
References: <1460627269-21721-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-1-git-send-email-joel@jms.id.au>
Message-ID: <3904749.OZ1gvV2E7A@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 17:33:58 Joel Stanley wrote:
> Hello!
> 
> These patches add basic support for the Aspeed AST2400 SoC, a popular BMC
> device that is also the target for our OpenBMC[1] efforts.
> 
> This series has been boot tested on a Palmetto OpenPower dev board that
> uses the ast2400 as it's BMC, as well as Qemu (-M palmetto-bmc on 2.6-rc1).
> 
> Version two brings support for the AST2500. It's similar to the 2400, but with
> an ARM11 replacing the ARM9. I've boot tested it in Qemu and on the Aspeed
> AST2500 edk.

Looks good overall. I have a couple of comments, see the replies to the
individual patches.

Once the review comments are all addressed, please send a pull request
containing all the arch/arm patches to arm at kernel.org and have the
drivers (clk, irq, clocksource) merged by the respective subsystem
maintainers. The DT bindings normally go together with the drivers,
but they can also get merged with the dts files.

For pull requests sent to arm at kernel.org, please split them up into
separate pull requests for different topics (dts files, defconfig,
arch code, cleanups, ...) so we can merge them into the appropriate
branches that we send to Linus during the merge window.

	Arnd
