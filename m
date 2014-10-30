From: rogerq@ti.com (Roger Quadros)
Date: Thu, 30 Oct 2014 14:26:18 +0200
Subject: [PATCH 05/10] ARM: OMAP2+: Fix support for multiple devices on
 a GPMC chip select
In-Reply-To: <1414628948-30702-6-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
 <1414628948-30702-6-git-send-email-tony@atomide.com>
Message-ID: <54522E6A.6060502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> There are cases where we have multiple device instances
> connected to a single GPMC chip select. For example, there
> are four UARTs on the Zoom debug boards that all share a
> single chip select and a GPIO interrupt.
> 
> We do have support for this already in theory, but it's broken
> because we're bailing out if the chip select is already taken.
> 
> To be able to provide checks on the chip select usage, let's
> add new struct gpmc_cs_data so we can start using already
> registered device names for checks.
> 
> Later on we probably want to start using struct gpmc_cs_data
> as a wrapper for all the GPMC chipselect related data.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
