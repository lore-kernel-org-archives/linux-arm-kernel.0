From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 21:06:51 -0600
Subject: [PATCH 6/6] ARM: bcm476x: Instantiate console UART
In-Reply-To: <20121007015407.840781689@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015407.840781689@gmail.com>
Message-ID: <507394CB.5080300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> The BCM476x sports standard PL011 UARTs which are fully described and
> put to use with these few changes.

Given that this SoC uses an interrupt controller for which there's
already a driver (so there's no need to wait for a later patch before
interrupts work), and that patch 1/6 adds debug/bcm476x.S anyway, I'd be
inclined to just squash this patch into the very first one myself.

If not, this patch isn't really just instantiating the console UART, but
also allowing the DEBUG_LL implementation to be selected.
